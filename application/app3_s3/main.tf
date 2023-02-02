module "app3_s3" {
  source = "../../modules/s3"
  
  appname       = var.appname
  env           = var.env
  uniqueid      = var.uniqueid
  s3count       = var.s3count
  deletion_days = var.deletion_days

}