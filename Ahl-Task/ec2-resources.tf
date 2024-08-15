# Public subnet EC2 instance 1
resource "aws_instance" "two-tier-web-server-1" {
  ami             = "ami-0932dacac40965a65"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.two-tier-ec2-sg.id]
  subnet_id       = aws_subnet.two-tier-pub-sub-1.id
  key_name        = "keyforwebserverrs"

  tags = {
    Name = "two-tier-web-server-1"
  }

  user_data = <<-EOF
#!/bin/bash


sudo apt update
sudo apt install nginx aws-cli -y
curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.zip
unzip amazon-cloudwatch-agent.zip -d /opt/aws/amazon-cloudwatch-agent
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << EOF
{
  "agent": {
    "run_as_user": "root"
  },
  "logs": {
    "logs": [
      {
        "file": "/var/log/nginx/access.log",
        "log_group_name": "/aws/nginx/access_log",
        "log_stream_name": "{instance_id}",
        "file_pattern": "^/var/log/nginx/access.log$",
        "datetime_format": "%Y/%m/%d %H:%M:%S",
        "log_format": "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
      },
      {
        "file": "/var/log/nginx/error.log",
        "log_group_name": "/aws/nginx/error_log",
        "log_stream_name": "{instance_id}",
        "file_pattern": "^/var/log/nginx/error.log$",
        "datetime_format": "%Y/%m/%d %H:%M:%S",
        "log_format": "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
      }
    ]
  },
  "metrics": {
    "collectd": {
      "collectd_config": "/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d/collectd.conf"
    }
  }
}

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start
sudo systemctl enable nginx
sudo systemctl start nginx

EOF


}



# Public subnet  EC2 instance 2
resource "aws_instance" "two-tier-web-server-2" {
  ami             = "ami-0932dacac40965a65"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.two-tier-ec2-sg.id]
  subnet_id       = aws_subnet.two-tier-pub-sub-2.id
  key_name        = "keyforwebserverrs"

  tags = {
    Name = "two-tier-web-server-2"
  }

  user_data = <<-EOF
#!/bin/bash

sudo apt update
sudo apt install nginx aws-cli -y
curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.zip
unzip amazon-cloudwatch-agent.zip -d /opt/aws/amazon-cloudwatch-agent
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << EOF
{
  "agent": {
    "run_as_user": "root"
  },
  "logs": {
    "logs": [
      {
        "file": "/var/log/nginx/access.log",
        "log_group_name": "/aws/nginx/access_log",
        "log_stream_name": "{instance_id}",
        "file_pattern": "^/var/log/nginx/access.log$",
        "datetime_format": "%Y/%m/%d %H:%M:%S",
        "log_format": "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
      },
      {
        "file": "/var/log/nginx/error.log",
        "log_group_name": "/aws/nginx/error_log",
        "log_stream_name": "{instance_id}",
        "file_pattern": "^/var/log/nginx/error.log$",
        "datetime_format": "%Y/%m/%d %H:%M:%S",
        "log_format": "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
      }
    ]
  },
  "metrics": {
    "collectd": {
      "collectd_config": "/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d/collectd.conf"
    }
  }
}

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start
sudo systemctl enable nginx
sudo systemctl start nginx

EOF

}

#EIP

resource "aws_eip" "two-tier-web-server-1-eip" {
  vpc = true

  instance   = aws_instance.two-tier-web-server-1.id
  depends_on = [aws_internet_gateway.two-tier-igw]
}

resource "aws_eip" "two-tier-web-server-2-eip" {
  vpc = true

  instance   = aws_instance.two-tier-web-server-2.id
  depends_on = [aws_internet_gateway.two-tier-igw]
}