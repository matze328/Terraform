




# Zufälliges Passwort generieren für den DB-Benutzer
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# DB-Subnetzgruppe erstellen (für Multi-AZ oder VPC)
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.my_subnet.id]

  tags = {
    Name        = "MyDBSubnetGroup"
    Environment = "Dev"
  }
}

# RDS-Datenbankinstanz erstellen
resource "aws_db_instance" "my_db_instance" {
  identifier        = "mydbinstance"
  engine            = "mysql"                            # oder postgres, oracle, etc.
  engine_version    = "8.0"                              # Version der Datenbankengine
  instance_class    = "db.t3.micro"                      # Instance-Typ
  allocated_storage = 20                                 # Speicher in GB
  username          = "admin"                            # Master-Benutzername
  password          = random_password.db_password.result # Passwort aus dem Random Provider

  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true # Setze auf false in der Produktion

  tags = {
    Name        = "MyRDSInstance"
    Environment = "Dev"
  }
}
