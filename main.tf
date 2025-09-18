module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id


  depends_on = [module.vpc]
}

module "servers" {
  source    = "./modules/compute"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  sg_ids    = module.security_group.sg_ids

  depends_on = [
    module.vpc,
    module.security_group
  ]
}