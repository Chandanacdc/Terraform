data "aws_ami" "img" {
  most_recent      = true
  owners           = ["227067764165"]

  filter {
    name   = "name"
    values = ["jenkins"]
    }
}

data "aws_security_group" "sg1" {
  name = var.sg_name
}

resource "aws_instance" "myec2" {
   ami = data.aws_ami.img.id
   instance_type = var.instance_type
   iam_instance_profile = var.instance_profile
   key_name = var.key_name
   vpc_security_group_ids = [data.aws_security_group.sg1.id]
   tags = {
    Name = "${var.uniqueid}-${var.appname}-${var.env}-linux-01"
    uniqueid = var.uniqueid
    appname = var.appname
    environment = var.env
    appowner = var.appowner 
  }
}