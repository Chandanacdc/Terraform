variable "appname" {
  type        = string
  description = "Applicatio Name"
}
variable "uniqueid" {
  type        = string
  description = "Applicatio Unique Id"
}
variable "env" {
  type        = string
  description = "Applicatio Environment"
}
variable "s3count" {
  type        = number
  description = "No of s3 bucket to be created"
}

variable "deletion_days"{
  type        = number
  description = "No of Deletion days"
}