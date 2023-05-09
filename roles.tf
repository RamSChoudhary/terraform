data "azurerm_billing_enrollment_account_scope" "test" {
  billing_account_name    = "1234567890"
  enrollment_account_name = "0123456"
}

resource "azurerm_subscription" "test-subs" {
  subscription_name = "Test-Subscription"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.test.id
}
