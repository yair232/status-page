resource "aws_security_group" "db_SG" {
  name_prefix = "db_prefix"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
    source_security_group_id = var.eks_node_security_group_id
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "db_insta" {
  engine                 = "postgres"
  db_name                = var.db_name
  identifier             = "status-page"
  instance_class         = var.db_instance_class
  allocated_storage      = var.allocated_storage
  publicly_accessible    = true
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.db_SG.id]
  skip_final_snapshot    = true
  multi_az               = true

  tags = {
    Name = "Y&R-db"
  }
}
