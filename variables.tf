variable "ami" {
  type = map(string)
  default = {
    "projectA" = "ami-084568db4383264d4"
    "projectB" = "ami-04f167a56786e4b09"
  }
}

variable "region" {
  default = {
    "projectA" = "us-east-1"
    "projectB" = "us-east-2"
  }
  type = map(string)
}

variable "instance_type" {
  default = "t2.micro"
  type = string
}


