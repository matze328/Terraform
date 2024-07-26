# sicherheitsgruppen erstellen
resource "aws_security_group" "allow_ssh_http_https" {
  name   = "allow_ssh_http_https"
  vpc_id = aws_vpc.my_vpc.id # mein erstelltes VPC ID
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