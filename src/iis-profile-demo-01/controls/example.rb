# copyright: 2018, The Authors

describe iis_site('Default Web Site') do
  it { should exist }
  it { should be_running }
  it { should have_app_pool('DefaultAppPool') }
  it { should have_path('C:\inetpub\wwwroot') }
end