# 🌐 WebService Infrastructure on Azure

This project automates the deployment of a scalable web infrastructure on **Azure** using **Terraform**, **Ansible**, and **GitHub Actions**, with **Cloudflare** integration for DNS and Let's Encrypt SSL certificates.

## 🧰 Technologies Used

- **Terraform** – Infrastructure provisioning on Azure
- **Ansible** – Server configuration and NGINX setup
- **Cloudflare** – DNS and SSL certificate management
- **GitHub Actions** – CI/CD automation pipeline

## 🚀 What Does It Do?

1. Creates 2 Linux virtual machines (VMs) on Azure
2. Configures a Load Balancer with NAT rules for SSH access
3. Installs NGINX and deploys a PHP web application from GitHub
4. Automatically configures a DNS A record on Cloudflare
5. Installs SSL certificates from Let’s Encrypt on both VMs
6. Ensures high availability by alternating VM activation during SSL setup

## 📁 Project Structure

WebService/ <br>
├── ansible/ <br>
│ ├── inventory/ <br>
│ │ └── hosts.yml <br>
│ └── playbooks/ <br>
│ ├── setup_nginx.yml <br>
│ └── setup_ssl.yml <br>
├── terraform/ <br>
│ ├── main.tf <br>
│ ├── variables.tf <br>
│ └── outputs.tf <br>
└── .github/ <br>
└── workflows/ <br>
└── deploy.yml <br>


## 🔐 Required Secrets

Configure the following **secrets** in your private GitHub repository:

- `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`
- `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ZONE_ID`, `CLOUDFLARE_DOMAIN`, `CLOUDFLARE_RECORD_NAME`
- `SSH_PRIVATE_KEY` – used to SSH into Azure VMs

## ⚙️ Deployment

To deploy from GitHub:

1. Go to the **Actions** tab.
2. Select `Deploy WebService Infrastructure...`
3. Click **Run workflow**
4. The infrastructure and configuration will be handled automatically.

## 🌐 Access

Once the workflow completes, your website will be available at: https://<CLOUDFLARE_RECORD_NAME>.<CLOUDFLARE_DOMAIN>


---

Created with ☁️ by Luis David Salgado
