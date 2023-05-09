data "azurerm_billing_enrollment_account_scope" "test" {
  billing_account_name    = "test-account"
  enrollment_account_name = "test-enrollment"
}

resource "azurerm_subscription" "test-subs" {
  subscription_name = "Test-Subscription"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.test.id
}
