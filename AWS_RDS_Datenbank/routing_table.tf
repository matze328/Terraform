# Routing-Tabelle erstellen
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id # mein erstelltes VPC ID 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id # mein erstelltes Routing Tabelle ID
  }

  tags = {
    Name = "my_route_table"
  }
}

# Route Table mit dem Subnetz verknüpfen
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id           # meine erstellte Subnetz ID
  route_table_id = aws_route_table.my_route_table.id # meine erstellte RoutingTabelle ID
}