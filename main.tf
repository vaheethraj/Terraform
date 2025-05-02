resource "aws_instance" "test" {
  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
}