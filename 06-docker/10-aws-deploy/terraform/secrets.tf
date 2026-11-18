# 24-character password
resource "random_password" "db" {
  length  = 24
  special = false
}

resource "aws_secretsmanager_secret" "db" {
  name                    = "smartlead/db"
  recovery_window_in_days = 0 # lab: delete immediately so the name can be reused
}

# The six keys the app reads as Spring properties, assembled from real resources
resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    "spring.datasource.url"      = "jdbc:postgresql://${aws_db_instance.main.address}:5432/${aws_db_instance.main.db_name}?sslmode=require"
    "spring.datasource.username" = aws_db_instance.main.username
    "spring.datasource.password" = random_password.db.result
    "aws.queque-url"             = aws_sqs_queue.analysis.url
    "app.queue.name"             = aws_sqs_queue.analysis.name
    "enable.fake.hf"             = "true"
  })
}