# Azure RBAC with Terraform/OpenTofu – Training Examples

This directory contains all progressive examples used with the **terraform-az-fk-rbac** module.
The examples are designed as **incremental building blocks**, starting from a simple role assignment scenario and gradually expanding toward more realistic integrations with compute, storage, and networking.

These examples are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used to show how Azure authorization fits into broader infrastructure designs.

---

## 🧭 Example Overview

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **VM Access To Blob Storage** | Managed identity, Storage Blob Data Contributor, VM-to-Storage RBAC wiring |
| 02 | **AKS With ACR Attach** | AKS kubelet identity, ACR scope, explicit AcrPull role assignment |
| 03 | **Group Reader On Resource Group** | Entra ID security group, Resource Group scope, explicit Reader role assignment |

Each example builds on the **concepts** introduced in the previous one, but can be applied
independently for learning and experimentation.

---

## ⚙️ How to Use

Each example directory contains:
- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A minimal, runnable architecture (no placeholder resources)

To run an example:

```bash
cd examples/01_vm_storage_blob_access
tofu init
tofu plan
tofu apply
```

You can apply examples independently. As the module grows, the **recommended approach is sequential**:
01 → 02 → 03

This mirrors real-world RBAC design, where you typically start with a single principal, a single scope, and a single role before combining authorization with private networking or broader platform patterns.

---

## 🧩 Design Principles

- One example = one architectural goal
- No unused or placeholder resources
- Clear separation of concerns (principal creation vs RBAC assignment)
- RBAC designed to integrate with other modules (compute, storage, networking)
- Authorization logic remains readable and explicit

These examples intentionally avoid:
- Full enterprise IAM frameworks
- Hidden dependencies between examples
- Mixing too many concepts into the first onboarding scenario

---

## 🧩 Related Resources

- [FoggyKitchen Azure RBAC Module (terraform-az-fk-rbac)](../)
- [FoggyKitchen Azure Compute Module (terraform-az-fk-compute)](https://github.com/mlinxfeld/terraform-az-fk-compute)
- [FoggyKitchen Azure Storage Module (terraform-az-fk-storage)](https://github.com/mlinxfeld/terraform-az-fk-storage)
- [FoggyKitchen Azure VNet Module (terraform-az-fk-vnet)](https://github.com/mlinxfeld/terraform-az-fk-vnet)
- [FoggyKitchen Azure Private Endpoint Module (terraform-az-fk-private-endpoint)](https://github.com/mlinxfeld/terraform-az-fk-private-endpoint)
- [FoggyKitchen Azure Private DNS Module (terraform-az-fk-private-dns)](https://github.com/mlinxfeld/terraform-az-fk-private-dns)

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](../LICENSE) for details.

---

© 2026 FoggyKitchen.com — *Cloud. Code. Clarity.*
