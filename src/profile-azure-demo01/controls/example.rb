# copyright: 2018, The Authors

title "Sample Section"

# you add controls here
control "azure-virtual-machines-exist-check" do                                # A unique ID for this control.
  impact 1.0                                                                   # The criticality, if this control fails.
  title "Check resource groups to see if any VMs exist."                       # A human-readable title
  azurerm_resource_groups.names.each do |resource_group_name|                  # Plural resources can be leveraged to loop across many resources
    describe azurerm_virtual_machines(resource_group: resource_group_name) do
      it { should exist } # The test itself.
    end
  end
end

control "azure-vm-devop-check" do
  describe azurerm_virtual_machine(resource_group: 'rg-devopsdays', name: 'vm-devops-toolset') do
    it { should exist}
    its('location') { should eq 'westeurope' }
  end
end
