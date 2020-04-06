control 'check_webapp' do
    azurerm_webapps(resource_group: 'rg-crossdvlp-examples').names.each do |webName| 
        describe azurerm_webapp(resource_group: 'rg-crossdvlp-examples', name: webName) do
            it { should exist }
            its('properties.httpsOnly') { should cmp true }
            its('configuration.properties') { should have_attributes(http20Enabled: true) }
            its('configuration.properties') { should have_attributes(minTlsVersion: "1.2")}
        end
    end
end