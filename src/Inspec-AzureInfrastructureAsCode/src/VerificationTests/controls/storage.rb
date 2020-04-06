title "Check storage account and container settings"

#Read data from terraform output
terraformContent = inspec.profile.file('terraform.json')
terraformsParams = JSON.parse(terraformContent)

resource_group = terraformsParams['resource_group_name']['value']
storage_account_name= terraformsParams['storage_account_name']['value']
storage_container_name= terraformsParams['storage_container_name']['value']

describe azurerm_storage_account(resource_group: resource_group, name: storage_account_name) do
    it { should exist }
    its('properties.supportsHttpsTrafficOnly') { should be true }
  end

describe azurerm_storage_account_blob_container(resource_group: resource_group, 
                                                storage_account_name: storage_account_name,
                                                blob_container_name: storage_container_name) do
it { should exist }                                                    
its('properties') { should have_attributes(publicAccess: 'None') }
end
