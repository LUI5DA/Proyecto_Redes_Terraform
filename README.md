# 🛠️ Active Directory Service with Terraform + Ansible

This project demonstrates how to create infrastructure on **Azure** using **Terraform** for provisioning and **Ansible** for configuring Windows Server machines with Active Directory. It's ideal for modern DevOps environments that require automation and scalability.

## 🖼️ Overview

*(Insert image here later)*

## ✨ Features

- Automated creation of a Windows Server virtual machine using Terraform.
- Automatic configuration of Active Directory and user creation using Ansible.

## 📦 Requirements

- **Terraform** >= 1.5  
  👉 [Install Terraform + Quick Start Guide](https://developer.hashicorp.com/terraform/tutorials/azure-get-started)

- **Ansible** >= 2.10  
  👉 [Install Ansible Guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

- **Azure CLI**  
  👉 [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

- **Python** >= 3.8

- An active **Azure subscription**

> **Note:** These instructions assume you are using a **Linux** machine.

## 🚀 How to Use

### 1. Clone this repository

```bash
git clone https://github.com/LUI5DA/ADService_with_terraform.git
````

### 2. Set up Azure credentials

Terraform requires credentials to connect to your Azure account and create resources.
👉 [Full tutorial on configuring credentials](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build)

**Login to Azure using Azure CLI:**

```bash
az login
```

This will open a browser window. After logging in, the CLI will show a list of your subscriptions.

**Set your desired subscription:**

```bash
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

**Create service principal credentials:**

```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```

**Export credentials as environment variables:**

```bash
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"
```

Once the environment is set, you're ready to run Terraform and Ansible.
