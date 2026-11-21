# Which subnets RDS may use: the two isolated db subnets
resource "aws_db_subnet_group" "main" {
  name       = "${var.project}-db-subnets"
  subnet_ids = [aws_subnet.db_a.id, aws_subnet.db_b.id]
  tags       = { Name = "${var.project}-db-subnets" }
}

# Reject any connection that isn't TLS
resource "aws_db_parameter_group" "postgres" {
  name   = "${var.project}-pg16"
  family = "postgres16"

  parameter {
    name         = "rds.force_ssl"
    value        = "1"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_instance" "main" {
  identifier     = "${var.project}-db"
  engine         = "postgres"
  engine_version = "16"
  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  storage_type      = "gp2"
  storage_encrypted = true

  db_name  = "smartlead"
  username = "smartlead_app"
  password = random_password.db.result

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.postgres.name
  publicly_accessible    = false
  multi_az               = var.db_multi_az

  backup_retention_period = 1
  skip_final_snapshot     = true  # lab only: a real deployment keeps a final snapshot
  deletion_protection     = false # lab only
  apply_immediately       = true

  tags = { Name = "${var.project}-db" }
}