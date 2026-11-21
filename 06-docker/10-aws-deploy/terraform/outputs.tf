output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "app_subnet_ids" {
  value = [aws_subnet.app_a.id, aws_subnet.app_b.id]
}

output "db_subnet_ids" {
  value = [aws_subnet.db_a.id, aws_subnet.db_b.id]
}

output "db_endpoint" {
  value = aws_db_instance.main.address
}

output "queue_url" {
  value = aws_sqs_queue.analysis.url
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "app_url" {
  value = "https://${var.app_domain}"
}