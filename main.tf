provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "tolle-ec2" {
    instance_type = "t2.micro"
    ami = "ami-0e872aee57663ae2d"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = "popel123"

tags = {
    Name = "tolle-ec2"       
  }
  }
  # sicherheitsgruppen erstellen

  resource "aws_security_group" "allow_ssh" {
  
  }

resource "aws_security_group_rule" "ingress_ssh" {
  from_port = 22
  to_port = 22
  security_group_id = aws_security_group.allow_ssh.id
  protocol = "tcp"
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]

  
}
 # Instanz-IP ausgeben 
 output "beispiel_ip" {
  value = aws_instance.tolle-ec2.public_ip
   
 }