# terraform-azure-mcaf-subscription-management
This terraform module will be able to manage subscriptions in either CSP or EA

## Find billing account information within Enterprise Agreement.

1. login with your credentials

```powershell
az login -t your-tenant-id-here
az billing account list --query "[].id"
# or
$AccountName = (az billing account list --query "[].id" -o json) | ConvertFrom-Json
```
The output will give you your account name
if you want to see all details, remove the query part.

2. check your billing information

```powershell
az billing profile list --account-name $AccountName --expand "InvoiceSections" --query "[].invoiceSections[].value[].id"
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version |
| ------------------------------------------------------------------------- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7  |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi)             | 1.15.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | ~> 4.0  |

## Providers

| Name                                                          | Version |
| ------------------------------------------------------------- | ------- |
| <a name="provider_azapi"></a> [azapi](#provider\_azapi)       | 1.15.0  |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                   | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [azapi_resource.this](https://registry.terraform.io/providers/azure/azapi/1.15.0/docs/resources/resource)                                              | resource    |
| [azurerm_billing_mca_account_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/billing_mca_account_scope) | data source |
| [azurerm_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group)                   | data source |

## Inputs

| Name                                                                                                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Type                                                                                                                                                                                                                                                                    | Default | Required |
| ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_billing_account_name"></a> [billing\_account\_name](#input\_billing\_account\_name)                           | The name of the billing account                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `string`                                                                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_billing_profile_name"></a> [billing\_profile\_name](#input\_billing\_profile\_name)                           | The name of the billing profile                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `string`                                                                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_invoice_section_name"></a> [invoice\_section\_name](#input\_invoice\_section\_name)                           | The name of the invoice section                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `string`                                                                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_parent_management_group_name"></a> [parent\_management\_group\_name](#input\_parent\_management\_group\_name) | The name of the parent management group                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `string`                                                                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_subscription"></a> [subscription](#input\_subscription)                                                       | The subscription configuration. The workload is set to 'Production' by default.<br><br>- `subscription_name` = optional(string) - The name of the subscription to manage.<br>- `subscription_owner_id` = optional(string) - The ID of the subscription owner.<br>- `tags` = optional(map(string)) - The tags to apply to the subscription.<br>- `workload` = optional(string) - The workload of the subscription. Defaults to 'Production'.<br><br>  Example Inputs:<pre>hcl<br>  sub1 = {<br>    subscription_name = "Subscription1"<br>    subscription_owner_id = "00000000-0000-0000-0000-000000000000"<br>    tags = {<br>      Environment = "application1"<br>    }<br>  }</pre>hcl | <pre>map(object({<br>    subscription_name          = optional(string)<br>    subscription_owner_id      = optional(string)<br>    tags                       = optional(map(string))<br>    workload                   = optional(string, "Production")<br>  }))</pre> | n/a     |   yes    |
| <a name="input_subscription_owner_id"></a> [subscription\_owner\_id](#input\_subscription\_owner\_id)                        | The ID of the subscription owner                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `string`                                                                                                                                                                                                                                                                | `null`  |    no    |
| <a name="input_subscription_type"></a> [subscription\_type](#input\_subscription\_type)                                      | The type of subscription to create                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `string`                                                                                                                                                                                                                                                                | n/a     |   yes    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                               | The tags to apply to the subscription                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `map(string)`                                                                                                                                                                                                                                                           | n/a     |   yes    |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id)                                                              | The ID of the tenant                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`                                                                                                                                                                                                                                                                | `null`  |    no    |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## License

**Copyright:** Schuberg Philis

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
