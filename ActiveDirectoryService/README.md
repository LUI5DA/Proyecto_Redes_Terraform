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
    └── deploy-ActiveDirectory.yml
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
- **Cloudfare DNS** — the Cloudfare DNS API is used to create a DNS Register for our domain.
---

## 🚦 How to Test the Project using GitHub Actions

This project is designed to be tested and deployed automatically using GitHub Actions.  
Everything is orchestrated by the pipeline defined in `.github/workflows/deploy.yml`.

### 1️⃣ Fork or Clone the Repository

```bash
git clone https://github.com/LUI5DA/Proyecto_Redes_Terraform.git
cd Proyecto_Redes_Terraform
```

### 2️⃣ Configure GitHub Secrets

To enable the pipeline to deploy to your Azure subscription and connect via Ansible, set the following **GitHub Secrets** in your repository (`Settings` > `Secrets and variables` > `Actions`):

- `ARM_CLIENT_ID`
- `ARM_CLIENT_SECRET`
- `ARM_SUBSCRIPTION_ID`
- `ARM_TENANT_ID`
- (Luego agregar las de cloudfare y usuario administrador del AD)

These are required for Terraform to authenticate with Azure.

### 3️⃣ Push Changes or Trigger the Workflow

- Any push to `main` (or a pull request) will automatically trigger the pipeline.
- The workflow will:
  1. Checkout your code.
  2. Set up Terraform and authenticate with Azure.
  3. Run `terraform init`, `plan`, and `apply` to provision the infrastructure.
  4. Extract the public IP and credentials from Azure.
  5. Run the Ansible playbooks to configure the VM and deploy Active Directory.
  6. Optionally, run checks/tests and clean up if required.

You can monitor the workflow progress and logs under the **Actions** tab on GitHub.

### 4️⃣ Verify the Deployment

- Once the pipeline completes, you’ll find the VM and Active Directory service running in your Azure portal.
- The workflow logs will show outputs (such as public IP) and the status of each step.
- You can connect to the deployed VM or test the AD service as needed.

---

## 📝 Manual Testing (Optional)

If you want to run the steps locally:

1. **Deploy infrastructure**  
   ```bash
   cd ActiveDirectoryService/terraform
   terraform init
   terraform apply
   ```
2. **Configure inventory** (update `ansible/inventory/hosts.yml` with the VM’s public IP and credentials).
3. **Run Ansible playbooks**
   ```bash
   cd ../ansible
   ansible-playbook -i inventory/hosts.yml playbooks/install_ad.yml
   ansible-playbook -i inventory/hosts.yml playbooks/create_users.yml
   ```

(agregar lo del par de llaves y configurar la ruta)

---

## 👤 Author

- [LUI5DA](https://github.com/LUI5DA)

---

## ⚡ Notes

- Destroy infrastructure after use to avoid unnecessary costs:
  ```bash
  cd terraform
  terraform destroy
  ```
- Customize `variables.tf` and `terraform.tfvars` for your environment.
- The pipeline can be extended to include tests, notifications, or more advanced deployment logic.

---

Contributions and feedback are welcome! 🌟
