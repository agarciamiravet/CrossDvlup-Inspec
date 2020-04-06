resource_group_dosconf = 'rg-dosconf2020-keyvault'
resource_group_madrid_dotnet = 'keyvault'

keyvault_dosconf = 'kv-dosconf2020'
keyvault_MadridDotNet = 'terraformMadridDotNet'

location = 'westeurope'

#Plural resources
control 'check_keyvault_'
describe azurerm_key_vaults(resource_group: resource_group_dosconf) do
    it            { should exist }
    its('names')  { should include keyvault_dosconf }
end


describe azurerm_key_vaults(resource_group: resource_group_madrid_dotnet) do
    it            { should exist }
    its('names')  { should include keyvault_MadridDotNet }
end

#Singular resources

describe azurerm_key_vault(resource_group: resource_group_dosconf, vault_name: keyvault_dosconf) do
    it              { should exist }
    its('name')     { should eq(keyvault_dosconf) }
    its('location') { should cmp location } 
  end

  describe azurerm_key_vault(resource_group: resource_group_madrid_dotnet, vault_name: keyvault_MadridDotNet) do
    it            { should exist }
    its('name')   { should eq(keyvault_MadridDotNet) }
    its('location') { should cmp location }   
  end