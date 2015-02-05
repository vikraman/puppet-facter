require 'spec_helper'

describe 'facter' do
  it { should contain_class('facter') }
  it { should compile.with_all_deps }
  it { should contain_class('facter::package') }
  it { should contain_file('/etc/facter').that_comes_before('File[/etc/facter/facts.d]').with_ensure('directory') }
  it { should contain_file('/etc/facter/facts.d').with_ensure('directory') }

  PuppetSpecFacts.facts_for_platform_by_name(
    [
      "Debian_wheezy_7.7_amd64_3.7.2_structured",
      "CentOS_5.11_x86_64_3.7.1_structured",
      "SLES_11.1_x86_64_3.1.1_stringified"
    ]
  ).each do |name, facthash|
    let(:facts) { facthash }
    context "on #{name}" do
      it { should contain_package('facter').with_ensure('present') }
    end
  end

  context 'on Gentoo' do
    let(:facts) { { :osfamily => 'Gentoo' } }
    let(:params) { { :provider => 'portage' } }
    it { should contain_package('dev-ruby/facter').with_ensure('present') }
    it { should_not contain_package('facter') }
    it { should contain_class('facter::package::portage') }
  end

  context 'when using gem as provider' do
    let(:params) { { :provider => 'gem' } }
    it do should contain_package('facter').with(
      'ensure'   => 'present',
      'provider' => 'gem',
    ) end
  end

  context 'when using custom package name' do
    let(:params) { { :package_name => 'custom_facter' } }
    it { should contain_package('custom_facter').with_ensure('present') }
  end
end
