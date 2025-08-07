# DMZ-Based Secure Three-Tier Architecture

## Overview

This project provisions a **secure DMZ-based three-tier architecture** on AWS using Terraform. All compute resources (Web, App, DB tiers) are placed in **private subnets**, while **only security boundary components** (WAF, ALB, NAT Gateway, Bastion Host) exist in public subnets. This structure provides **enhanced security isolation**, **controlled inbound/outbound traffic**, and **tier-based access restrictions**.

## Tech Stack

- Terraform (modular infrastructure as code)
- AWS EC2 (Web & App Tier)
- AWS RDS (DB Tier)
- AWS WAF (Web Application Firewall)
- AWS ALB (Application Load Balancer)
- AWS NAT Gateway & Bastion Host
- Ubuntu 24.04
- Nginx + Flask + MySQL
- Shell scripts: `setup_web.sh`, `setup_app.sh`, `setup_bastion.sh`

## Directory Structure

```
.
├── modules/
│   ├── vpc/                # VPC, Subnets, NAT Gateway, Route Tables
│   ├── security_group/     # Security Groups per tier (Web, App, DB, ALB, Bastion)
│   ├── waf/                # WAF ACL and association with ALB
│   ├── alb/                # Application Load Balancer setup
│   ├── bastion_host/       # Bastion EC2 for administrative SSH access
│   ├── ec2_web/            # Auto Scaling Group for Web Tier EC2
│   ├── ec2_app/            # Auto Scaling Group for App Tier EC2
│   └── rds/                # AWS RDS for MySQL database
├── scripts/
│   ├── setup_web.sh
│   ├── setup_app.sh
│   └── setup_bastion.sh
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── README.md
```

## How to Use

### Create resources

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

> Make sure your AWS key pair matches the one declared in terraform.tfvars (e.g. dmz-key.pem).
> 

### Verify Inbound Connection

- Access via browser:
    
    ```
    http://<alb_dns_name>
    → “Welcome to Web Tier!”
    ```
    

### SSH Access (Through Bastion Only)

```bash
$ ssh -i dmz-key.pem ubuntu@<bastion_public_ip>
$ ssh -i dmz-key.pem ubuntu@<web_private_ip>
$ ssh -i dmz-key.pem ubuntu@<app_private_ip>
```

### Web → App → DB Communication

- From Web EC2:
    
    ```
    curl http://<app_private_ip>:5000
    ```
    
- From App EC2:
    
    ```
    mysql -h <rds_endpoint> -u <username> -p
    ```
    

### Remove all resources

```bash
$ terraform destroy
```

## Features / Main Logic

- **DMZ-Based Tier Isolation**
    - Only WAF, ALB, Bastion Host, and NAT Gateway exist in **public subnets**.
    - Web, App, and DB EC2 instances are completely **isolated in private subnets**.
- **WAF Integration**
    - AWS WAF is attached to the ALB.
    - Protects against SQL Injection, XSS, and other OWASP Top 10 threats via AWS managed rule sets.
- **Strict Security Group Configuration**
    - Only specific tier-to-tier ports allowed (e.g. Web → App: 5000, App → DB: 3306).
    - SSH access only via Bastion from an allowed IP (`ssh_allowed_ip`).
- **ALB Configuration**
    - Public-facing entry point
    - Forwards only HTTP (port 80) to Web Tier (which is private)
    - Integrated with WAF ACL
- **NAT Gateway for Outbound**
    - Allows private Web/App/DB EC2s to access the internet for updates while keeping them unexposed to public access.
- **Bastion Host**
    - Lightweight EC2 in Public Subnet for administrative access.
    - Hardened with security best practices (`fail2ban`, restricted IP, no root login, etc.).
- **Modular Terraform**
    - Reusable modules for scalability and clean management
    - Supports multiple AZs and Auto Scaling for resilience
- **Auto Scaling Group**
    - Web & App EC2s are deployed using ASGs in private subnets
    - Ensures high availability and scalability

## Motivation / Expected Impact

- Simulates an **enterprise-grade, production-ready architecture** with **network isolation**.
- Demonstrates a secure AWS environment aligned with **least privilege** and **zero trust** principles.
- Provides a **reusable and extensible infrastructure codebase** for future projects (e.g., containerization, blue/green deployments, centralized logging, etc.).