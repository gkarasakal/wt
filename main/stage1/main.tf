module "vpc" {
  source              = "../../modules/vpc"
  env                 = local.env
  private_cidr_blocks = var.private_cidr_blocks[local.env]
  public_cidr_blocks  = var.public_cidr_blocks[local.env]
  vpc_cidr_block      = var.vpc_cidr_block[local.env]
}

module "iam" {
  source                                = "../../modules/iam"
}