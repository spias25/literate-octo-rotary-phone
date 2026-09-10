module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "~> 6.0"
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  public_subnet_tags   = { "kubernetes.io/role/elb" = 1 }
  private_subnet_tags  = { "kubernetes.io/role/internal-elb" = 1 }
  tags                 = var.tags
}
output "vpc_id" {
  value = module.vpc.vpc.id
}
output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

