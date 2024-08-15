resource "aws_db_instance" "two-tier-db-1" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  # Use a supported MySQL version for RDS
  engine_version          = "8.0"  # You can choose another supported version
  instance_class          = "db.t3.micro"
  db_subnet_group_name    = "two-tier-db-sub"
  vpc_security_group_ids  = [aws_security_group.two-tier-db-sg.id]
  parameter_group_name    = "default.mysql8.0"  # Update parameter group for version 8.0
  db_name                 = "two_tier_db1"
  username                 = "admin"
  password                 = "password"
  allow_major_version_upgrade = true
  auto_minor_version_upgrade = true
  backup_retention_period  = 35
  backup_window            = "22:00-23:00"
  maintenance_window      = "Sat:00:00-Sat:03:00"
  multi_az                  = false
  skip_final_snapshot      = true
}