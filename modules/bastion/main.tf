resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.dmz_subnet_id
  vpc_security_group_ids = [var.sg_bastion_id]
  key_name               = var.key_pair_name

  associate_public_ip_address = true

  user_data = file(var.user_data_file)

  tags = {
    Name = "${var.project}-bastion"
  }
}
