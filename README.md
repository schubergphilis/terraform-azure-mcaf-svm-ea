# terraform-azure-mcaf-subscription-management-ea
This terraform module will be able to manage subscriptions for Enterprise Agreements.

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
