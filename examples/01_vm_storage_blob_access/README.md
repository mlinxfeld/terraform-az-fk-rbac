# Example 01: VM Access To Blob Storage

In this RBAC example, we move from a standalone role-assignment module
to a **real integrated scenario** where a Virtual Machine uses
its **system-assigned managed identity** to write data to Azure Blob Storage.

This example focuses on **authorization wiring**
while still deploying the minimal infrastructure required to prove the result end-to-end.

---

## 🧭 Architecture Overview

This deployment creates a single Linux VM,
a single Storage Account with Blob Containers,
and a role assignment connecting both through Azure RBAC.

The VM is created with a **system-assigned managed identity**.
That identity receives the **Storage Blob Data Contributor** role
on the Storage Account scope via the `terraform-az-fk-rbac` module.

<img src="01_vm_storage_blob_access_architecture.png" width="900"/>

This example creates:
- One **Resource Group**
- One **Virtual Network** with a single subnet via `terraform-az-fk-vnet`
- One **Linux Virtual Machine** via `terraform-az-fk-compute`
- One **Storage Account (StorageV2)** via `terraform-az-fk-storage`
- Two **private Blob Containers** (`artifacts`, `logs`) via `terraform-az-fk-storage`
- One **RBAC role assignment** via `terraform-az-fk-rbac`
- Cloud-init setup that installs **Azure CLI** and prepares a helper upload script on the VM

This is an **RBAC integration example**, not a full production landing zone.

---

## 🎯 Why this example exists

The purpose of this example is to show how authorization should be modeled
as a **separate layer** instead of being embedded directly inside compute or storage modules.

This example focuses on:
- Understanding how a VM gets an Azure AD / Entra principal through managed identity
- Understanding how a Storage Account becomes the RBAC scope
- Understanding how a dedicated RBAC module connects principals and scopes cleanly
- Proving the result by uploading a blob from inside the VM with `az login --identity`

The example deliberately keeps networking simple so the first RBAC scenario stays easy to follow.

---

## 🔐 About Access In This Example

This example demonstrates **RBAC-based authorization**, not private networking.

Important:
- the Blob service is reached through the **public Storage endpoint**
- the blob containers are still **private**
- access is granted through **managed identity + Azure RBAC**
- anonymous access is **not** enabled

This keeps the first RBAC example focused on **identity and authorization**.

More advanced patterns such as:
- Private Endpoints
- Private DNS
- storage firewall lockdown

can be layered on top later, but are intentionally out of scope here.

---

## 🚀 Deployment Steps

From the `examples/01_vm_storage_blob_access` directory:

```bash
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
tofu apply
```

---

## ✅ Managed Identity Validation

This example prepares the VM for a real blob upload test,
but it does not perform the upload automatically during boot.

That is intentional:
- managed identity role assignments can take time to propagate
- forcing the upload inside cloud-init would make the example less deterministic

Instead, cloud-init:
- installs `azure-cli`
- creates `/usr/local/bin/blob-proof.sh`

After `tofu apply`, you can trigger the upload from your workstation with Azure CLI:

```bash
RESOURCE_GROUP_NAME="$(tofu output -raw resource_group_name)"
VM_NAME="$(tofu output -raw vm_name)"
STORAGE_ACCOUNT_NAME="$(tofu output -raw storage_account_name)"

az vm run-command invoke \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --name "${VM_NAME}" \
  --command-id RunShellScript \
  --scripts "/usr/local/bin/blob-proof.sh ${STORAGE_ACCOUNT_NAME} logs proof.txt 'hello from managed identity'"
```

Then verify that the blob exists:

```bash
ACCOUNT_KEY="$(tofu output -raw storage_primary_access_key)"
STORAGE_ACCOUNT_NAME="$(tofu output -raw storage_account_name)"

az storage blob list \
  --account-name "${STORAGE_ACCOUNT_NAME}" \
  --account-key "${ACCOUNT_KEY}" \
  --container-name logs \
  --output table
```

---

## 🖼️ Azure Portal View

The screenshots below capture the same scenario in the Azure Portal.

<img src="01_vm_storage_blob_access_portal1.png" width="900"/>

*Figure 1. `Storage Blob Data Contributor` assigned to the VM managed identity on the Storage Account scope.*

<img src="01_vm_storage_blob_access_portal2.png" width="900"/>

*Figure 2. `proof.txt` uploaded to the `logs` container after the managed identity validation step.*

---

## 🔧 Key RBAC Wiring

```hcl
module "rbac" {
  source = "git::https://github.com/mlinxfeld/terraform-az-fk-rbac.git?ref=v0.1.0"

  scope                = module.storage.storage_account_id
  principal_id         = module.compute.vm_principal_id
  role_definition_name = "Storage Blob Data Contributor"
}
```

---

## 🧹 Cleanup

```bash
tofu destroy
```

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](../../LICENSE) for details.
