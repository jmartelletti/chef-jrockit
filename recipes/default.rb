#
# Cookbook Name:: chef-jrockit
# Recipe:: default
#
# Copyright 2014, SPS Commerce
#
# All rights reserved - Do Not Redistribute
#

media_path = node['media_path']
jrockit_file = node['jrockit_file']
jrockit_install_path = node['jrockit_install_path']
jrockit_base_url = node['jrockit_base_url']

jrockit_url = "#{jrockit_base_url}/#{jrockit_file}"

# Create media directory
directory media_path do
  mode '0755'
  recursive true
end

# Silent install config file
template "#{media_path}/jrockit-silent.xml" do
  owner 'root'
  group 'root'
  mode '0644'
  source 'silent.xml.erb'
  variables(
    :jrockit_install_path => jrockit_install_path
  )
end

# Grab the jrockit installer
remote_file "#{media_path}/#{jrockit_file}" do
  owner 'root'
  group 'root'
  mode '0755'
  source jrockit_url
end

# Run the jrockit silent install.
execute 'install_jrockit' do
  command "#{media_path}/#{jrockit_file} -mode=silent -silent_xml=#{media_path}/jrockit-silent.xml"
  not_if { ::File.directory?(jrockit_install_path) }
end

# Load the jrocket path into a user's shell
template "/etc/profile.d/jrockit.sh" do
  owner 'root'
  group 'root'
  mode '0755'
  source 'jrockit_path.sh.erb'
  variables(
    :jrockit_install_path => jrockit_install_path
  )
end
