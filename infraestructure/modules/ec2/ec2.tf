resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = var.name
  }

  provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo yum install -y python3 git",
        "sudo yum install -y python3-pip",  
        "sudo yum install -y nodejs",       
        "sudo npm install -g pm2",          
        "cd /home/ec2-user",
        "git clone https://github.com/cloudops-services/EC2-Application-ML-Demo.git",
        "cd EC2-Application-ML-Demo",
        "pip install requiriments.txt",
        "pm2 start app.py --interpreter=python3 --name ml-demo-app",
        "pm2 startup",
        "pm2 save"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.key_pair_private_key_path)
    host        = self.public_ip
  }
}
