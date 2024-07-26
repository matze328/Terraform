provider "aws" {
  region = "eu-central-1"
}
# EC2 Instance 
resource "aws_instance" "euer-lieblings-gebäck" {
    instance_type = "t2.micro"
    ami = "ami-071878317c449ae48" # Amazon Linux 2023 AMI 
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_https.id] #meine erstellte Sicherheitsgruppe
   subnet_id = aws_subnet.my_subnet.id  # von meinem erstellten subnetz
  key_name = "popel123" # Schlüsselpaar

tags = {
    Name = "euer-lieblings-gebäck"       
  }
  }

# mein VPC erstellen
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" 
 enable_dns_hostnames = true
  enable_dns_support = true 

  tags = {
    Name = "my_vpc"
  }
  }
  # mein Subnetz
  resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id 
  cidr_block        = "10.0.1.0/24"     
  availability_zone = "eu-central-1a"
   map_public_ip_on_launch = true  
    tags = {
    Name = "my_subnet"
  }
}

# Internet Gateway erstellen
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id # mein erstelltes VPC ID

  tags = {
    Name = "my_internet_gateway"
  }
}

# Routing-Tabelle erstellen
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id  # mein erstelltes VPC ID 

  route {
    cidr_block                = "0.0.0.0/0"          
    gateway_id                = aws_internet_gateway.my_igw.id  # mein erstelltes Routing Tabelle ID
  }

  tags = {
    Name = "my_route_table"
  }
}

# Route Table mit dem Subnetz verknüpfen
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id            # meine erstellte Subnetz ID
  route_table_id = aws_route_table.my_route_table.id  # meine erstellte RoutingTabelle ID
}


  # sicherheitsgruppen erstellen
 resource "aws_security_group" "allow_ssh_http_https" {
  name        = "allow_ssh_http_https" 
  vpc_id      = aws_vpc.my_vpc.id   # mein erstelltes VPC ID
 # SSH Eingehender Datenverkehr
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
# HTTP Eingehender Datenverkehr
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
# HTTPS Eingehender Datenverkehr
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  # aussgehnder Datenverkehr
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
 }
 }
 # Instanz-Public-IP ausgeben 
 output "beispiel_ip" {
  value = aws_instance.euer-lieblings-gebäck.public_ip
   
 }


 # aufgabe2 
 # Welchen Unterschied gibt es bei dein Regeln für ausgehenden Datenverkehr?
# Antwort:  bei der defalut wird ausgehnder daten verkewhr erlaubt und bei der andern fehlte es 
# Was hat dieser Unterschied für Folgen für eine Verbindung mit der EC2-Instanz?
# die sitzung kann nicht verbunden werden time out 