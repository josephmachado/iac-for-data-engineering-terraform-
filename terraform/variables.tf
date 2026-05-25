variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "input_bucket" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
