title 'Check virtualmachine settings'

control "azure-virtualmachines-check-settings" do
    title 'Check security settings of virtual machines'
    azurerm_vmlist.ids.each do |vmID|
      vmIdArray = vmID.split('/')
      resourcegroup =  vmIdArray[4]
      virtualmachine =  vmIdArray[8]
      describe azurerm_virtual_machine(resource_group: resourcegroup, name: virtualmachine) do
        its('location') { should cmp 'westeurope' }
      end
    end
  end