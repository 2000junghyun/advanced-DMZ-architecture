resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.project}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project}-rds"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.instance_type
  allocated_storage       = 20
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.db_sg_id]

  publicly_accessible     = false
  multi_az                = false
  skip_final_snapshot     = true

  tags = {
    Name = "${var.project}-rds"
  }
}
