module "app1_ec2" {
  source = "../../modules/ec2"
  
  uniqueid = var.uniqueid
  instance_type = var.instance_type
  appname = var.appname
  appowner = var.appowner
  env = var.env
  sg_name = var.sg_name
  instance_profile = var.instance_profile
  key_name = var.key_name
  
}