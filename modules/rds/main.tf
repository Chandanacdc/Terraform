data "aws_security_group" "sg1" {
  name = var.sg_name
}

resource "aws_db_instance" "rds" {
  allocated_storage         = var.allocated_storage
  db_name                   = "${var.appname}-${var.env}-${var.engine}-${var.engine_version}"
  engine                    =  var.engine
  vpc_security_group_ids    = [data.aws_security_group.sg1.id]
  engine_version            = var.engine_version
  instance_class            = var.size
  username                  = var.uname
  password                  = var.password
  storage_encrypted         = true
  skip_final_snapshot       = true
  backup_window             = var.backup_window
  backup_retention_period   = (can(regex("prod", var.env))) ? 35 : 7
  maintenance_window        = var.maintenance_window


  tags = {
    Name = "${var.appname}-${var.env}-${var.engine}-${var.engine_version}"
    appname = var.appname
    env = var.env
    db_engine=var.engine
    version = var.engine_version
  }
 
}