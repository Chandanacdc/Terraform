module "app2_rds" {
  source = "../../modules/rds"
  
  appname       = var.appname
  env           = var.env
  sg_name       = var.sg_name
  uname         = var.uname
  password      =var.password
  allocated_storage=var.allocated_storage
  engine_version=var.engine_version
  engine        =var.engine
  size          =var.size

}