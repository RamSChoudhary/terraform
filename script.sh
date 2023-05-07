#!/bin/bash

echo "Installing AzureCLI"
apt-get update
            # install requirements
apt-get install -y curl apt-transport-https lsb-release gnupg jq
            # add Microsoft as a trusted source
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
apt-get update
apt-get install azure-cli

az login -u ramrit10@gmail.com -p Azure@1441
set -eu 
agentIP=$(curl -s https://api.ipify.org/)
  
az keyvault network-rule add --resource-group test-rg --name test-kv1441 --ip-address $agentIP
   
sleep 40s