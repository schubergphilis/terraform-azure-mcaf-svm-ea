variable "subscription_type" {
  description = "The type of subscription to create"
  type        = string

  validation {
    condition     = contains(["CSP", "MCA"], var.subscription_type)
    error_message = "The subscription type must be either 'CSP' or 'EA'."
  }
}

variable "billing_account_name" {
  description = "The name of the billing account"
  type        = string
  default     = null
}

variable "billing_profile_name" {
  description = "The name of the billing profile"
  type        = string
  default     = null
}

variable "invoice_section_name" {
  description = "The name of the invoice section"
  type        = string
  default     = null
}

variable "parent_management_group_name" {
  description = "The name of the parent management group"
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "The ID of the tenant"
  type        = string
  default     = null
}

variable "tags" {
  description = "The tags to apply to the subscription"
  type        = map(string)
}

variable "subscription_owner_id" {
  description = "The ID of the subscription owner"
  type        = string
  default     = null
}

variable "subscription" {
  type = map(object({
    subscription_name     = optional(string)
    subscription_owner_id = optional(string)
    tags                  = optional(map(string))
    workload              = optional(string, "Production")
  }))
  nullable    = false
  description = <<DESCRIPTION
The subscription configuration. The workload is set to 'Production' by default.

- `subscription_name` = optional(string) - The name of the subscription to manage.
- `subscription_owner_id` = optional(string) - The ID of the subscription owner.
- `tags` = optional(map(string)) - The tags to apply to the subscription.
- `workload` = optional(string) - The workload of the subscription. Defaults to 'Production'.

  Example Inputs:

  ```hcl
  sub1 = {
    subscription_name = "Subscription1"
    subscription_owner_id = "00000000-0000-0000-0000-000000000000"
    tags = {
      Environment = "application1"
    }
  }
  ```hcl

DESCRIPTION

  validation {
    condition     = alltrue([for s in var.subscription : contains(["Production", "DevTest"], s.workload)])
    error_message = "The workload must be either 'Production' or 'DevTest'."
  }
}