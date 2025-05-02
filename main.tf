resource "aws_instance" "test" {
  ami = var.ami
  instance_type = var.instance_type["instance_type"]
}