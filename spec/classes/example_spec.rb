require 'spec_helper'

describe 'ssh_authorized_keys' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "ssh_authorized_keys class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('ssh_authorized_keys::params') }

        it { should contain_class('ssh_authorized_keys::install').that_comes_before('ssh_authorized_keys::config') }
        it { should contain_class('ssh_authorized_keys::config') }
        it { should contain_class('ssh_authorized_keys::service').that_subscribes_to('ssh_authorized_keys::config') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'ssh_authorized_keys class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
