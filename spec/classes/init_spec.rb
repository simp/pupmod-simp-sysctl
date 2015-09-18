require 'spec_helper'

describe 'sysctl' do

  it { should create_class('sysctl') }

  it do
    should contain_file('/etc/sysctl.d/').with({
      'ensure' => 'directory',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0755',
    })
  end

  it do
    should contain_file('/etc/sysctl.d/20-simp.conf').with({
      'ensure'  => 'present',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0600',
      'require' => 'File[/etc/sysctl.d/]'
    })
  end

end
