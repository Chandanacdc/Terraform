variable "uniqueid" {
  description = "Unique id of the Application"
  type = string
}

variable "instance_type" {
  description = "Instance type of the Application server"
  type = string
}

variable "appname" {
  description = "Application Name"
  type = string
}

variable "appowner" {
  description = "Owner of the Application"
  type = string
}

variable "env" {
  description = "Application Environment"
  type = string
}

variable "sg_name" {
  description = "security group name"
  type = string
}

variable "instance_profile" {
  description = "Iam instance profile"
  type = string
}

variable "key_name" {
  description = "key name of the server"
  type = string
}