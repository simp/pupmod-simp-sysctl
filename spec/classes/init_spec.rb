require 'spec_helper'

describe 'sysctl' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to create_class('sysctl') }

        it do
          is_expected.to contain_file('/etc/sysctl.d/').with({
            'ensure' => 'directory',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0755',
          })
        end

        it do
          is_expected.to contain_file('/etc/sysctl.d/20-simp.conf').with({
            'ensure'  => 'present',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0600'
          })
        end

      end
    end
  end
end
