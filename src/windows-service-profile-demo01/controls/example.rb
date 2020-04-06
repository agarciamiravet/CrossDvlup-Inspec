# copyright: 2018, The Authors

title "sample section"

control 'check_service_dns' do
  describe service('Dnscache') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

describe service('DHCP Client') do
  it { should be_installed }
  it { should be_running }
end