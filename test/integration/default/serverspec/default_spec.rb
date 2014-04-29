# encoding: utf-8
require 'spec_helper'
require 'uri'

media_path = @properties['chef_jrockit']['media_path']
jrockit_file = @properties['chef_jrockit']['jrockit_file']
jrockit_install_path = @properties['chef_jrockit']['jrockit_install_path']
jrockit_base_url = @properties['chef_jrockit']['jrockit_base_url']

uri = URI.parse(jrockit_base_url)
fileserverhostname = uri.host
fileserverport = uri.port

# netcat is needed for testing
puts 'Installing netcat for URL testing...'
system('yum -y install nc')

describe host(fileserverhostname) do
  it { should be_resolvable }
  it { should be_reachable.with(port: fileserverport, proto: 'tcp') }
end

describe file(media_path) do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("#{media_path}/#{jrockit_file}") do
  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("#{media_path}/jrockit-silent.xml") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) do
    should \
    match(/.*"USER_INSTALL_DIR" value="#{Regexp.escape(jrockit_install_path)}"/)
  end
  its(:content) do
    should \
    match(/.*"PUBLIC_JRE_INSTALL_DIR" value="#{Regexp.escape(jrockit_install_path)}"/)
  end
end

describe command("#{jrockit_install_path}/bin/java -version") do
  it { should return_exit_status 0 }
  its(:stdout) { should match(/.*JRockit.*/) }
end

describe file('/etc/profile.d/jrockit.sh') do
  it { should be_file }
  it { should be_readable }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match(/#{Regexp.escape(jrockit_install_path)}\/bin/) }
end
