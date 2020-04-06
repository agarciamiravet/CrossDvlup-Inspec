control 'check_servicebus_namespace' do
    describe azurerm_servicebus_namespace(resource_group: 'rg-crossdvlp-examples',namespace_name: 'sbcrossdvlupinspec') do
      it  { should exist }
      it { should have_basic_tier }
      its('sku.tier') { should cmp 'Basic'}
    end
end