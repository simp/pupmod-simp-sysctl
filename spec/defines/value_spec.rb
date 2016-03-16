require 'spec_helper'

describe 'sysctl::value' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts){ facts }

        let(:title){'net.unix.max_dgram_qlen'}

        let(:params){{:value => '50'}}

        target = '/etc/sysctl.conf'
        if os =~ /(?:redhat|centos)-(\d+)/
          if $1.to_i >= 7
            target = '/etc/sysctl.d/20-simp.conf'
          end
        end
        let(:target){ target }

        it do
          is_expected.to contain_sysctl('net.unix.max_dgram_qlen').with({
            'ensure' => 'present',
            'val'    => '50',
            'apply'  => true,
            'target' => target
          })
        end

        context 'with value => nil' do

          let(:params) { {:value => 'nil'} }

          it do
            is_expected.to contain_sysctl('net.unix.max_dgram_qlen').with({
              'ensure' => 'absent',
              'val'    => 'nil',
              'apply'  => true,
              'target' => target
            })
          end
        end

      end
    end
  end
end
