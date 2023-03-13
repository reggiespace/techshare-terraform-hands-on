module "techshare-vpc" {
  source         = "./modules/vpc"
  prefix         = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
}

module "techshare-ec2" {
  source                 = "./modules/ec2"
  prefix                 = var.prefix
  instance_name          = var.instance_name
  instance_type          = var.instance_type
  ami_id                 = "${var.prefix}-ami"
  subnet_id              = module.techshare-vpc.subnet_ids[0]
  vpc_security_group_ids = [module.techshare-vpc.security_group_id]
  allow_ssh_from         = var.vpc_cidr_block
}
