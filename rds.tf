resource "aws_db_instance" "wordpress" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  username             = var.db_user
  password             = jsondecode(data.aws_secretsmanager_secret_version.example.secret_string)["password"] #var.db_pass
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.default.id]
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "private" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  tags = {
    Name = "My DB subnet group"
  }
}
 