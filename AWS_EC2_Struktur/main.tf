
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


# aufgabe2 
 # Welchen Unterschied gibt es bei dein Regeln für ausgehenden Datenverkehr?
# Antwort:  bei der defalut wird ausgehnder daten verkewhr erlaubt und bei der andern fehlte es 
# Was hat dieser Unterschied für Folgen für eine Verbindung mit der EC2-Instanz?
# die sitzung kann nicht verbunden werden time out 