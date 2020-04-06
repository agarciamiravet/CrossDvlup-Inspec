title "Check web app pasionporlosbits"

#Read data from terraform output
terraformContent = inspec.profile.file('terraform.json')
terraformsParams = JSON.parse(terraformContent)

resource_group = terraformsParams['resource_group_name']['value']
web_name = terraformsParams['web_name']['value']

control "azure_webapp_pasionporlosbits"
describe azurerm_webapp(resource_group: resource_group, name: web_name) do
  it { should exist }
  its('properties.httpsOnly') { should cmp true }
  its('properties.enabledHostNames') { should include "www.pasionporlosbits.com" }
  its('configuration.properties') { should have_attributes(http20Enabled: true) }
  its('configuration.properties') { should have_attributes(minTlsVersion: "1.2")}
end