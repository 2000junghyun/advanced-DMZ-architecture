#!/bin/bash
# Bastion EC2 인스턴스 초기 설정 스크립트

# 시스템 업데이트
apt-get update -y
apt-get upgrade -y

# fail2ban 설치 (보안 강화)
apt-get install -y fail2ban

# 타임존 설정 (필요 시)
timedatectl set-timezone UTC

# bash profile에 로그인 배너 추가 (선택 사항)
echo "Welcome to the Bastion Host" >> /etc/motd