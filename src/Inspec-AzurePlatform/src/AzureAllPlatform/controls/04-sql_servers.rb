control "azure-sqlserver-check-settings" do
  title 'Check security settings of sqlserver'
  azurerm_sqlserverlist.ids.each do |sqlServerId|
    sqlServerIdArray = sqlServerId.split('/')
    resourcegroup =  sqlServerIdArray[4]
    sqlServerName =  sqlServerIdArray[8]
    describe azurerm_sql_databases(resource_group: resourcegroup, server_name: sqlServerName) do
      it            { should exist }
      its('names')  { should_not be_empty }
    end      
  end
end