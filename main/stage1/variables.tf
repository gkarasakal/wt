locals {
  env = terraform.workspace

  private_subnet_ids = tolist(
  module.vpc.private_subnet.*.id
  )

  public_subnet_ids = tolist(
  module.vpc.public_subnet.*.id
  )

  vpc_id = module.vpc.vpc_id

  allowed_ips = {
    staging   : concat(var.ops_ips),
    production: concat(var.ops_ips)
  }
}

# VPC variables start
variable "public_cidr_blocks" {
  type    = map(list(string))
  default = {
    staging: [
      "10.1.1.0/24",
      "10.1.2.0/24",
      "10.1.3.0/24"
    ],
    production: [
      "10.0.1.0/24",
      "10.0.2.0/24",
      "10.0.3.0/24"
    ]
  }
}

variable "private_cidr_blocks" {
  type    = map(list(string))
  default = {
    staging: [
      "10.1.4.0/24",
      "10.1.5.0/24",
      "10.1.6.0/24"
    ],
    production: [
      "10.0.4.0/24",
      "10.0.5.0/24",
      "10.0.6.0/24"
    ]
  }
}

variable "vpc_cidr_block" {
  type    = map(string)
  default = {
    staging   : "10.1.0.0/16",
    production: "10.0.0.0/16"
  }
}

variable "ops_ips" {
  type    = list(string)
  default = [
    "83.84.104.185/32" // Gokhan Home
  ]
}
# VPC variables end

# IAM variables start
variable "oidc_provider_url" {
  type    = map(string)
  default = {
    staging   : "https://oidc.eks.eu-west-1.amazonaws.com/id/8E555D6C107B14A30D6EDB5BE5663B21"
    production: ""
  }
}
# IAM variables end

# EKS variables start
variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. Possible values [`api`, `audit`, `authenticator`, `controllerManager`, `scheduler`]"
  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
}

variable "ondemand_node_pool_instance_types" {
  type    = map(list(string))
  default = {
    staging: [
      "t3.medium"
    ],
    production: [
      "m4.xlarge"
    ]
  }
}

variable "ondemand_node_pool_desired_size" {
  type    = map(number)
  default = {
    staging: 1
    production: 6
  }
}


variable "ondemand_node_pool_max_size" {
  type    = map(number)
  default = {
    staging: 6
    production: 10
  }
}

variable "ondemand_node_pool_min_size" {
  type    = map(number)
  default = {
    staging: 1
    production: 3
  }
}
# EKS variables end

# ECR variables start
variable "ecr_lifecycle_image_count" {
  type    = map(number)
  default = {
    staging   : 2
    production: 5
  }
}
# ECR variables end

# RDS variables start
variable "rds_cluster_id" {
  type    = string
  default = "gokhan-wt-db"
}

variable "engine_mode" {
  type    = string
  default = "serverless"
}

variable "engine_version" {
  type    = string
  default = "5.7.mysql_aurora.2.08.3"
}

variable "db_name" {
  type    = string
  default = "GokhanWTDB"
}

variable "min_capacity" {
  type    = map(string)
  default = {
    staging   : "2"
    production: "4"
  }
}

variable "max_capacity" {
  type    = map(string)
  default = {
    staging   : "16"
    production: "32"
  }
}

variable "deletion_protection" {
  type    = map(string)
  default = {
    staging    = false,
    production = true
  }
}

variable "db_snapshot_identifier" {
  type    = map(string)
  default = {
    staging   : ""
    production: ""
  }
}

variable "rds_backup_retention_period" {
  type    = map(number)
  default = {
    staging     = 1
    production  = 30
  }
}
# RDS variables end
