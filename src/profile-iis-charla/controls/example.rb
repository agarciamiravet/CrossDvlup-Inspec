# copyright: 2018, The Authors


control 'iis_test_deafault_website' do
  describe iis_site('Default Web Site') do
    it { should exist }
    it { should be_running }
    it { should have_app_pool('DefaultAppPool') }
  end
end

