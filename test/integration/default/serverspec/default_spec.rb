require 'spec_helper'

describe file('/u01/media') do
  it { should be_directory }
end

describe file('/u01/media/jrockit-silent.xml') do
  it { should be_file }
  its(:content) { should match /.*"USER_INSTALL_DIR" value="\/u01\/app\/oracle\/jrockit.*"/ }
  its(:content) { should match /.*"PUBLIC_JRE_INSTALL_DIR" value="\/u01\/app\/oracle\/jrockit.*"/ }
end

describe command('/u01/app/oracle/jrockit/bin/java -version') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /.*JRockit.*/ }
end

describe file('/etc/profile.d/jrockit.sh') do
  it { should be_file }
  it { should be_readable }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /\/u01\/app\/oracle\/jrockit\/bin/ }
end
