resource "aws_instance" "Project" {
  ami = lookup(var.ami, terraform.workspace) 
  instance_type = var.instance_type
  tags = {
    Name = terraform.workspace
  }
}















