resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "vaheeth-vpc"
    managed_by = "terraform"
  }
}

resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "vaheeth-vpc-igw"
    managed_by = "terraform"
  }
}

resource "aws_subnet" "pub-sub" {
 vpc_id = aws_vpc.vpc1.id
 cidr_block = "10.0.1.0/24"
 availability_zone = "us-east-1a"
 tags = {
   Name = "pub-sub"
   managed_by = "terraform"
 }
}

resource "aws_subnet" "priv-sub" {
 vpc_id = aws_vpc.vpc1.id
 cidr_block = "10.0.2.0/24"
 availability_zone = "us-east-1b"
 tags = {
   Name = "priv-sub"
 }
}

resource "aws_route_table" "pub-sub-rt" {
 vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1_igw.id
  }
  tags = {
    Name = "pub-sub-rt"
    managed_by = "terraform"
  }
}

resource "aws_route_table" "priv-sub-rt" {
 vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "priv-sub-rt"
    managed_by = "terraform"
  }
}

resource "aws_route_table_association" "pub-sub-rt-assn" {
  subnet_id = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.pub-sub-rt.id
}

resource "aws_route_table_association" "priv-sub-rt-assn" {
  subnet_id = aws_subnet.priv-sub.id
  route_table_id = aws_route_table.priv-sub-rt.id
}

resource "aws_security_group" "sg1" {
  vpc_id = aws_vpc.vpc1.id
  name = "my-sg1"
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "6"
    cidr_blocks      = ["106.222.197.91/32"]
  }
  ingress {
    from_port        = 90
    to_port          = 80
    protocol         = "6"
    cidr_blocks      = ["106.222.197.91/32"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-sg1"
    managed_by = "terraform"
  }
}

resource "aws_instance" "ec2-1" {
  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub-sub.id
  vpc_security_group_ids = [aws_security_group.sg1.id]
}

