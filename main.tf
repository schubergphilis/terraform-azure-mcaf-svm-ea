data "azurerm_client_config" "current" {}

data "azurerm_billing_mca_account_scope" "this" {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}

data "azurerm_management_group" "this" {
  name = var.parent_management_group_name
}

resource "azapi_resource" "this" {
  for_each = var.subscription

  type      = "Microsoft.Subscription/aliases@2021-10-01"
  name      = each.value.subscription_name
  parent_id = "/"
  body = { properties = {
    additionalProperties = {
      managementGroupId    = data.azurerm_management_group.this.id
      subscriptionOwnerId  = each.value.subscription_owner_id == null ? var.subscription_owner_id : each.value.subscription_owner_id
      subscriptionTenantId = data.azurerm_client_config.current.tenant_id
      tags = {
        for k, v in merge(var.tags, each.value.tags) : k => v
      }
    }
    billingScope = data.azurerm_billing_mca_account_scope.this.id
    displayName  = each.value.subscription_name
    workload     = each.value.workload
    }
  }
}
