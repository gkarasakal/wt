locals {
  region = "eu-west-1"
  env    = terraform.workspace
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "allowed_ips" {
  type = list(string)
}

variable "rds_cluster_id" {
  type    = string
}

variable "engine_mode" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "db_name" {
  type    = string
}

variable "min_capacity" {
  type    = string
}

variable "max_capacity" {
  type    = string
}

variable "deletion_protection" {
  type    = string
}

variable "db_snapshot_identifier" {
  type    = string
}

variable "rds_backup_retention_period" {
  type    = number
}
