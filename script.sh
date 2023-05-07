#!/bin/bash

echo "Installing AzureCLI"
      apt-get update
      apt-get install azure-cli

      az login -u ramrit10@gmail.com -p Azure@1441
      set -eu 
      agentIP=$(curl -s https://api.ipify.org/)
   
      az keyvault network-rule add --resource-group test-rg --name test-kv1441 --ip-address $agentIP
   
      sleep 30