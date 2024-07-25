provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "tolle-ec2" {
    instance_type = "t2.micro"
    ami = "ami-0e872aee57663ae2d"
  vpc_security_group_ids = ["sg-0e9a1cf95d737fff2"]
  key_name = "popel123"

tags = {
    Name = "tolle-ec2"       
  }
  }