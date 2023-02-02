variable "appname" {
  description = "Application Name"
  type = string
}

variable "env" {
  description = "Environment Name"
  type = string
   validation {
    condition     = var.env="dev" || var.env="qa" || var.env="prod"
    error_message = "the environment name you entered is not correct, the correct options are, dev, qa, prod"
  }
}

variable "sg_name" {
  description = "security group name"
  type = string
}
variable "uname" {
  description = "User Name"
  type = string
}
variable "password" {
  description = "Password"
  type = string
}
variable "allocated_storage" {
  description = "allocated storage"
  type = number
}
variable "engine_version" {
  description = "engine version"
  type = string
}

variable "backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: 09:46-10:16"
  default     = "01:00-01:30"
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: \"ddd:hh24:mi-ddd:hh24:mi\". For example: \"Mon:00:00-Mon:03:00\"."
  default     = "Sun:02:00-Sun:02:30"
}
variable "size" {
  type        = string
  description = "Size of the DB"

  validation {
    condition     = var.size == "db.t4g.micro" || var.size == "db.t3.micro"
    error_message = "the db size you entered is not correct, the correct options are, db.t4g.micro and  db.t3.micro"
  }
}

variable "engine" {
  type        = string
  description = "database Engine"

  validation {
    condition     = substr(var.engine, 0, 5) == "mysql" || substr(var.engine, 0, 5) == "mssql" || substr(var.engine, 0, 6) == "oracle" || substr(var.engine, 0, 8) == "postgres" 
    error_message = "the db version you entered is not correct, the correct options are, postgres, mysql, mssql, oracle"
  }
}
