#!/bin/bash

# 필수 패키지 설치
apt update -y
apt install -y python3-pip python3-venv

# 홈 디렉토리 기준으로 작업
cd /home/ubuntu

# 가상환경 생성 및 Flask 설치
python3 -m venv venv
source venv/bin/activate
./venv/bin/pip install --upgrade pip
./venv/bin/pip install flask

# Flask 앱 작성
cat > app.py <<EOF
from flask import Flask
app = Flask(__name__)
@app.route('/')
def index():
    return "Hello from App Tier!"
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# 소유자 변경 (보안 및 권한 보장)
chown -R ubuntu:ubuntu /home/ubuntu

# systemd 서비스 등록
cat > /etc/systemd/system/flask.service <<EOF
[Unit]
Description=Flask App
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=/home/ubuntu/venv/bin/python /home/ubuntu/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# systemd 서비스 적용
systemctl daemon-reload
systemctl enable flask
systemctl start flask