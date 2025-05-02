variable "region" {
  default = ""
  type = list(string)
  description = "Test"
}

variable "instance_type" {
  default = {
    "instance_type" = "t2.micro"
    "instance_types" = "t3.micro"
  }
  type = map(string)
  description = "Instance Type"
}