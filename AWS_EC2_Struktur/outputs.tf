# Instanz-Public-IP ausgeben 
output "public_ip" {
  value = aws_instance.euer-lieblings-gebäck.public_ip

}
output "instance_id" {
  value = aws_instance.euer-lieblings-gebäck.id

}