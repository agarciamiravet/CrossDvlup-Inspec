
describe azurerm_network_security_group(resource_group: 'rg-devopsdays', name: 'vm-devops-toolset-nsg') do
    it { should exist }
    it { should allow_ssh_from_internet }
end