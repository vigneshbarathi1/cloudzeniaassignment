provider "aws" {
  region = "us-east-1"  # You can change this based on your region
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name = "wordpress-db-credentials"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "wordpress_user",
    password = "@admin1"
  })
}
