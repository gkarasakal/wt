resource "aws_db_subnet_group" "private_subnets" {
  name       = "gokhan-private-rds-subnet"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "Gokhan RDS Private Subnet Group"
    Project     = "WT"
    Environment = local.env
  }
}

resource "aws_db_subnet_group" "public_subnets" {
  name       = "gokhan-public-mysql-subnet"
  subnet_ids = var.public_subnet_ids

  tags = {
    Name        = "Gokhan RDS Public Subnet Group"
    Project     = "WT"
    Environment = local.env
  }
}

data "aws_secretsmanager_secret_version" "rds_creds" {
  secret_id = "gokhan/${local.env}/rds"
}

resource "aws_security_group" "rds-security-group" {
  name        = "Gokhan WT RDS Security Group"
  description = "Gokhan WT RDS Security Group"
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = 3306
    protocol        = "TCP"
    to_port         = 3306
    cidr_blocks     = var.allowed_ips
  }

  ingress {
    from_port       = 3306
    protocol        = "TCP"
    to_port         = 3306
    security_groups = [var.eks_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

/*
  Aurora Serverless MySQL DB for WT Staging Environment
*/
resource "aws_rds_cluster" "db-cluster" {
  cluster_identifier     = var.rds_cluster_id
  db_subnet_group_name   = aws_db_subnet_group.private_subnets.name
  engine                 = "aurora-mysql"
  engine_mode            = var.engine_mode
  engine_version         = var.engine_version
  master_username        = jsondecode(data.aws_secretsmanager_secret_version.rds_creds.secret_string)["master_username"]
  master_password        = jsondecode(data.aws_secretsmanager_secret_version.rds_creds.secret_string)["master_password"]
  database_name          = var.db_name
  scaling_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  vpc_security_group_ids = [aws_security_group.rds-security-group.id]
  apply_immediately      = true
  deletion_protection    = var.deletion_protection

  tags = {
    Name         = var.db_name
    Project      = "WT"
    Environment  = local.env
  }
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.db_name}db-snapshot-${formatdate("YYYY-MM-DD-hh", timestamp())}"
  snapshot_identifier       = var.db_snapshot_identifier
  backup_retention_period   = var.rds_backup_retention_period
}
