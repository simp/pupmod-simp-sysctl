require 'spec_helper'

describe 'sysctl' do

  it { should create_class('sysctl') }

  it do
    should contain_file('/etc/sysctl.conf').with({
      'ensure' => 'present',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0600'
    })
  end

end
