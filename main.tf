provider "aws" {
  region = "eu-central-1"
}
# Amazon Linux 2023 AMI 
resource "aws_instance" "euer-lieblings-gebäck" {
    instance_type = "t2.micro"
    ami = "ami-071878317c449ae48"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_https.id]
   subnet_id = aws_subnet.my_subnet.id
  key_name = "popel123"

tags = {
    Name = "euer-lieblings-gebäck"       
  }
  }

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # CIDR-Block für die VPC
 enable_dns_hostnames = true
  enable_dns_support = true 

  tags = {
    Name = "my_vpc"
  }
  }
  resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id # ID der erstellten VPC
  cidr_block        = "10.0.1.0/24"      # CIDR-Block für das Subnetz
  availability_zone = "eu-central-1a"
   map_public_ip_on_launch = true
    tags = {
    Name = "my_subnet"
  }
}
  # sicherheitsgruppen erstellen

 resource "aws_security_group" "allow_ssh_http_https" {
  name        = "allow_ssh_http_https" 
  vpc_id      = aws_vpc.my_vpc.id
 # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
# HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
# HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
 }
 }
 # Instanz-IP ausgeben 
 output "beispiel_ip" {
  value = aws_instance.euer-lieblings-gebäck.public_ip
   
 }


 # aufgabe2 
 # Welchen Unterschied gibt es bei dein Regeln für ausgehenden Datenverkehr?
# Antwort:  bei der defalut wird ausgehnder daten verkewhr erlaubt und bei der andern fehlte es 
# Was hat dieser Unterschied für Folgen für eine Verbindung mit der EC2-Instanz?
# die sitzung kann nicht verbunden werden time out 