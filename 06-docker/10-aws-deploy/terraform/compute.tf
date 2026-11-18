locals {
  compose_file = replace(file("${path.module}/../docker-compose.yml"), "\r\n", "\n")

  app_image = "${aws_ecr_repository.app.repository_url}:${var.app_image_tag}"


  user_data = <<-EOT
    #!/bin/bash
    set -euxo pipefail

    dnf install -y docker amazon-ecr-credential-helper
    systemctl enable --now docker
    mkdir -p /root/.docker
    echo '{"credsStore":"ecr-login"}' > /root/.docker/config.json

    mkdir -p /usr/local/lib/docker/cli-plugins
    curl -fSL "https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-$(uname -m)" \
      -o /usr/local/lib/docker/cli-plugins/docker-compose
    chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

    mkdir -p /opt/smartlead
    cat > /opt/smartlead/docker-compose.yml <<'COMPOSEEOF'
    ${local.compose_file}
    COMPOSEEOF

    cd /opt/smartlead
    ECR_IMAGE=${local.app_image} docker compose up -d
  EOT
}


#no hardcoding
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


resource "aws_launch_template" "app" {
  name_prefix   = "${var.project}-app-"
  image_id      = data.aws_ssm_parameter.al2023.value
  instance_type = var.app_instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }

  vpc_security_group_ids = [aws_security_group.app.id]

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  user_data = base64encode(replace(local.user_data, "\r\n", "\n"))

  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "${var.project}-app" }
  }
}


resource "aws_autoscaling_group" "app" {
  name                = "${var.project}-asg"
  min_size            = 2
  desired_capacity    = 2
  max_size            = 2
  vpc_zone_identifier = [aws_subnet.app_a.id, aws_subnet.app_b.id]

  # Switch to "ELB" in Layer 4, once the load balancer's health check exists
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app.id
    version = aws_launch_template.app.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
      max_healthy_percentage = 110
    }
  }


  depends_on = [
    aws_route_table_association.app_a,
    aws_route_table_association.app_b,
    aws_secretsmanager_secret_version.db,
  ]

  tag {
    key                 = "Name"
    value               = "${var.project}-app"
    propagate_at_launch = true
  }
}