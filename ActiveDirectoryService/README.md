# 🟦 Active Directory Service on Azure  
*Automated Infrastructure Provisioning & Configuration with Terraform, Ansible & GitHub Actions* 🚀

---

## 🌟 Overview

This project automates the deployment of an **Active Directory** service on a virtual machine in Azure.  
**Terraform** is used for provisioning infrastructure, **Ansible** for configuring the VM and services, and **GitHub Actions** as the CI/CD orchestrator.  
The result is a reproducible, scalable, and maintainable solution for cloud-based Active Directory.

---

## 📁 Project Structure

```
ActiveDirectoryService/
├── .gitignore
├── README.md
├── ansible/
│   ├── inventory/
│   │   └── hosts.yml
│   └── playbooks/
│       ├── create_users.yml
│       └── install_ad.yml
└── terraform/
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tfvars
    └── variables.tf
.github/
└── workflows/
    └── deploy.yml
```

- **terraform/**: Defines and deploys the Azure infrastructure (VM, networking, supporting resources) ☁️
- **ansible/**: Configures the VM, installs and sets up Active Directory and user accounts 🤖
- **.github/workflows/**: Automated CI/CD pipeline using GitHub Actions 🔄

---

## 🛠️ Technologies Used

- **Terraform** — Infrastructure as Code (IaC) for provisioning Azure resources 🏗️
- **Ansible** — Automated configuration management and service deployment on the VM ⚙️
- **GitHub Actions** — Workflow orchestration and CI/CD automation 🏃‍♂️
- **Azure** — Cloud platform hosting the resources ☁️

---

## 🧑‍💻 How to Test the Project

### 1. Clone the repository
```bash
git clone https://github.com/LUI5DA/Proyecto_Redes_Terraform.git
cd Proyecto_Redes_Terraform/ActiveDirectoryService
```

### 2. Configure your Azure credentials  
Make sure your environment is authenticated to Azure, either via `az login` or by exporting Service Principal credentials as environment variables.

### 3. Deploy the infrastructure with Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply
```
This creates the VM and all required resources on Azure. 🌐

### 4. Configure the service with Ansible
Edit the inventory file (`ansible/inventory/hosts.yml`) with the public IP, username, and password of your VM:
```yaml
all:
  hosts:
    azure_vm:
      ansible_host: <VM_IP>
      ansible_user: <username>
      ansible_password: <password>
      ansible_connection: winrm
```
Then run the playbooks:
```bash
cd ../ansible
ansible-playbook -i inventory/hosts.yml playbooks/install_ad.yml
ansible-playbook -i inventory/hosts.yml playbooks/create_users.yml
```

### 5. (Optional) Automation with GitHub Actions  
The workflow in `.github/workflows/deploy.yml` can automate the above steps on each push or pull request, enabling full CI/CD. 🤖

---

## 👤 Author

- [LUI5DA](https://github.com/LUI5DA)

---

## 📝 Notes

- Remember to destroy the infrastructure when finished to avoid unnecessary costs:
  ```bash
  cd terraform
  terraform destroy
  ```
- Customize `variables.tf` and `terraform.tfvars` as needed for your environment. 🛡️

---

Contributions and feedback are welcome! 🌟
