# terraform-az-fk-rbac

This repository contains a reusable **Terraform / OpenTofu module** and progressive examples for assigning **Azure Role-Based Access Control (RBAC)** permissions to principals such as Virtual Machines, managed identities, service principals, and groups.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses/azure-fundamentals-terraform-course/)** and is designed as a **small, composable authorization layer** that integrates with other Azure modules such as compute, storage, and networking.

---

## 🎯 Purpose

The goal of this module is to provide a **clear, educational, and architecture-aware reference implementation** for Azure RBAC:

- Focused on **role assignments**
- Explicit inputs and outputs — no hidden dependencies
- Designed to integrate cleanly with:
  - Azure Storage
  - Virtual Machines and managed identities
  - Subscription, resource group, and resource scopes

This is **not** a full IAM framework or policy engine.  
It is a **learning-first, building-block module**.

---

## ✨ What the module does

The module creates a single Azure role assignment based on three explicit inputs:

- `scope`
- `principal_id`
- `role_definition_name`

This keeps authorization logic:

- easy to compose with other modules
- easy to read in example architectures
- easy to reuse across different Azure resource types

The module intentionally does **not** create:

- Azure AD / Entra principals
- Resource Groups
- Storage Accounts
- Virtual Machines
- Private Endpoints
- Policy definitions or policy assignments

Each of those concerns belongs in its **own dedicated module**.

---

## 📂 Repository Structure

```bash
terraform-az-fk-rbac/
├── examples/
│   ├── 01_vm_storage_blob_access/
│   ├── 02_aks_with_acr_attach/
│   └── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```

---

## 🚀 Example Usage

```hcl
module "rbac" {
  source = "git::https://github.com/mlinxfeld/terraform-az-fk-rbac.git?ref=v0.1.0"

  scope                = module.storage.storage_account_id
  principal_id         = module.compute.vm_principal_id
  role_definition_name = "Storage Blob Data Contributor"
}
```

This module is intentionally minimal:

- `scope` defines where the role applies
- `principal_id` defines who receives the role
- `role_definition_name` defines what access is granted

That makes the module easy to compose with other FoggyKitchen Azure modules.

---

## 🧪 Example Scenarios

The repository currently includes two end-to-end examples:

- `examples/01_vm_storage_blob_access` shows a VM managed identity receiving
  `Storage Blob Data Contributor` on a Storage Account scope
- `examples/02_aks_with_acr_attach` shows an AKS kubelet identity receiving
  `AcrPull` on an Azure Container Registry scope

These examples demonstrate the same module pattern reused across different Azure services:

- principal comes from a dedicated workload module
- scope comes from a dedicated resource module
- RBAC stays explicit as a small composition layer

---

## 📤 Outputs

| Output | Description |
|------|-------------|
| `role_assignment_id` | The ID of the created Azure role assignment |

---

## 🧠 Design Philosophy

- Authorization should stay **explicit**, not hidden inside resource modules
- Principals and scopes should come from **other dedicated modules**
- RBAC wiring should be **small, readable, and composable**
- Outputs are first-class citizens

---

## 🧩 Related Modules & Training

- [terraform-az-fk-compute](https://github.com/mlinxfeld/terraform-az-fk-compute)
- [terraform-az-fk-storage](https://github.com/mlinxfeld/terraform-az-fk-storage)
- [terraform-az-fk-vnet](https://github.com/mlinxfeld/terraform-az-fk-vnet)
- [terraform-az-fk-private-endpoint](https://github.com/mlinxfeld/terraform-az-fk-private-endpoint)
- [terraform-az-fk-private-dns](https://github.com/mlinxfeld/terraform-az-fk-private-dns)

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for details.

---

© 2026 FoggyKitchen.com — *Cloud. Code. Clarity.*
