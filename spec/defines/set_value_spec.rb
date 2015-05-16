require 'spec_helper'

describe 'sysctl::set_value' do

  let(:title) {'net.unix.max_dgram_qlen'}

  let(:params) { {:value => '50'} }

  it do
    should contain_sysctl('net.unix.max_dgram_qlen').with({
      'ensure' => 'present',
      'val' => '50',
      'require' => 'File[/etc/sysctl.conf]'
    })
  end

  it do
    should contain_sysctl_set_value('net.unix.max_dgram_qlen').with({
      'val' => '50'
    })
  end

  context 'with value => nil' do

    let(:params) { {:value => 'nil'} }

    it do
      should contain_sysctl('net.unix.max_dgram_qlen').with({
        'ensure' => 'absent',
        'val' => 'nil',
        'require' => 'File[/etc/sysctl.conf]'
      })
    end
  end

end
