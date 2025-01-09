resource "aws_ecs_cluster" "wordpress_cluster" {
  name = "wordpress-cluster"
}

resource "aws_ecs_task_definition" "wordpress_task" {
  family                   = "wordpress-task"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([{
    name      = "wordpress"
    image     = "wordpress:latest"
    essential = true
    environment = [
      {
        name  = "DB_HOST"
        value = aws_rds_instance.wordpress_db.endpoint
      },
      {
        name  = "DB_NAME"
        value = "wordpress"
      },
      {
        name  = "DB_USER"
        value = "wordpress_user"
      },
      {
        name  = "DB_PASSWORD"
        valueFrom = {
          secretRef = aws_secretsmanager_secret.db_credentials.id
        }
      }
    ]
  }])
}

resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.wordpress_cluster.id
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }
  depends_on = [aws_ecs_task_definition.wordpress_task]
}

resource "aws_rds_instance" "wordpress_db" {
  identifier        = "wordpress-db"
  instance_class    = "db.t3.micro"  # Adjust as needed
  engine            = "mysql"
  engine_version    = "8.0"
  username          = "wordpress_user"
  password          = "secure_password"
  db_name           = "wordpress"
  allocated_storage = 20
  multi_az          = false
  storage_type      = "gp2"
  backup_retention_period = 7
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  publicly_accessible = false
  tags = {
    Name = "WordPress-DB"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "WordPressDBSubnetGroup"
  }
}

resource "aws_security_group" "ecs_sg" {
  name_prefix = "ecs-sg"
  description = "Allow traffic to ECS"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-sg"
  description = "Allow traffic to RDS"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ecs_to_rds" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = [aws_security_group.ecs_sg.id]
  security_group_id = aws_security_group.rds_sg.id
}

resource "aws_lb" "wordpress_alb" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "wordpress_target_group" {
  name        = "wordpress-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "wordpress_listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 301
      message_body = "Redirecting to HTTPS"
      content_type = "text/plain"
    }
  }

  depends_on = [aws_lb.wordpress_alb]
}

resource "aws_lb_listener" "wordpress_https_listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  certificate_arn = aws_acm_certificate.wordpress_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_target_group.arn
  }
}

resource "aws_acm_certificate" "wordpress_certificate" {
  domain_name = "wordpress.${var.domain_name}"
  validation_method = "DNS"
}

resource "aws_lb_listener_rule" "https_redirect" {
  listener_arn = aws_lb_listener.wordpress_listener.arn
  priority     = 1
  action {
    type             = "redirect"
    redirect {
      protocol = "HTTPS"
      port     = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Effect    = "Allow"
    }]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Effect    = "Allow"
    }]
  })
}
