module "networking" {
  source       = "../terraform-modules-june/networking-vpc"
  vpc_cidr     = var.vpc_cidr
  vpc_tendancy = var.vpc_tendancy
  vpc_name     = var.vpc_name
  subnet_cidr  = var.subnet_cidr
  subnet_name  = var.subnet_name
}

module "security_group" {
  source  = "../terraform-modules-june/security-groups"
  sg_name = "ICICI_ALLOW_ALL"
  vpc_id  = module.networking.vpc_id
}


module "ec2" {
  source        = "../terraform-modules-june/ec2"
  ec2_name      = "ICICI_INSTANCE"
  instance_type = "t2.micro"
  ami_id        = "ami-0d5eff06f840b45e9"
  subnet_id     = module.networking.subnet_id
  sg_id         = module.security_group.sg_id

}
