resource_group_key_vaults= 'rg-inspec-examples'

keyvault_inspec01 = 'kv-inspec-example01'
keyvault_inspec02 = 'kv-inspec-example02'

location = 'westeurope'

#Plural resources

control 'check_keyvaults' do
  describe azurerm_key_vaults(resource_group: resource_group_key_vaults) do
      it            { should exist }
      its('names')  { should include keyvault_inspec01 }
      its('names')  { should include keyvault_inspec02 }
  end
end

control "azure-keyvault-check-settings-all-platform" do
  title 'Check security settings of all keyvault in subscription'
  azurerm_key_vaults_list.ids.each do |keyVaultId|
    keyVaultIdArray = keyVaultId.split('/')
    resourcegroup =  keyVaultIdArray[4]
    keyVaultName =  keyVaultIdArray[8]

    describe azurerm_key_vault(resource_group: resourcegroup, vault_name: keyVaultName) do
      it              { should exist }
      its('location') { should cmp location } 
    end   

  end
end

#Singular resources

describe azurerm_key_vault(resource_group: resource_group_key_vaults, vault_name: keyvault_inspec01) do
    it              { should exist }
    its('name')     { should eq(keyvault_inspec01) }
    its('location') { should cmp location } 
  end

  describe azurerm_key_vault(resource_group: resource_group_key_vaults, vault_name: keyvault_inspec02) do
    it            { should exist }
    its('name')   { should eq(keyvault_inspec02) }
    its('location') { should cmp location }   
  end