
# 🌐 Networking Project: Automated Active Directory & Web Server on Azure

Deploy enterprise infrastructure in Azure with a single click!  
This project provisions and configures two essential services—**Active Directory** and a **Web Server**—using Infrastructure as Code, automated configuration, and CI/CD pipelines.

---

## 🚀 Overview

This repository contains two main subprojects:

- **[ActiveDirectoryService](./ActiveDirectoryService/README.md)**: Provisions a Windows VM and configures an Active Directory domain controller.
- **[WebService](./WebService/README.md)**: Provisions a Linux VM running an NGINX-based web server with SSL.

> ⚠️ **Important:**  
> The **WebService** subproject depends on the **ActiveDirectoryService**.  
> You must deploy the Active Directory service first before setting up the Web Server, as it may rely on directory services for authentication and integration.

---

## 🗂️ Project Structure

```
Proyecto_Redes_Terraform/
├── ActiveDirectoryService/
│   └── ... (infra, Ansible, and detailed README)
├── WebService/
│   └── ... (infra, Ansible, and detailed README)
└── .github/
    └── workflows/
        ├── deploy-ActiveDirectory.yml
        └── deploy-webServer.yml
```


![image](https://github.com/user-attachments/assets/5489e55d-a5f0-46bf-b5d7-a01b62332090)



---

## 🛠️ Technologies

- **Terraform** 🏗️ — Infrastructure as Code for provisioning Azure resources.
- **Ansible** ⚙️ — Automated configuration of VMs and services.
- **GitHub Actions** 🤖 — CI/CD and orchestration for fully automated deployments.
- **Azure** ☁️ — Cloud platform for hosting infrastructure.
- **NGINX** 🌐 — Web server with SSL configuration.
- **Windows Server & Active Directory** 🪟 — Domain controller for authentication and directory services.

---

## 🔗 How Services Relate

- **ActiveDirectoryService** deploys a Windows VM and configures it as a domain controller with users.
- **WebService** deploys a Linux VM running NGINX, which can be configured (optionally) to authenticate users against Active Directory or simply serve as a secure web frontend.
- **WebService** depends on the existence of **ActiveDirectoryService** for directory-based authentication or network integration.

---

## 📚 Get Started

To deploy and test each subproject, please refer to their dedicated documentation:

- 👉 [Readme for ActiveDirectoryService](./ActiveDirectoryService/README.md)
- 👉 [Readme for WebService](./WebService/README.md)

Each README provides step-by-step instructions, workflow details, and customization options specific to the service.

---

## 👤 Author

- [LUI5DA](https://github.com/LUI5DA)

---

## ⚡ Notes

- Destroy resources to avoid costs after testing.
- Contributions and feedback are welcome! 🌟

---

**Automate your infrastructure—from code to cloud—with one repository!!**
