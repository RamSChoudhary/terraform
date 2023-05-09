data "azurerm_billing_enrollment_account_scope" "test" {
  billing_account_name    = "ramrit10@gmail.com"
  enrollment_account_name = "pay-as-you-go"
}

resource "azurerm_subscription" "test-subs" {
  subscription_name = "Test-Subscription"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.test.id
  workload = "DevTest"
}
