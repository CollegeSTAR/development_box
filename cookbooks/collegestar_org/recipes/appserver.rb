#
# Cookbook Name:: collegestar_org
# Recipe:: appserver
#
# Copyright (c) 2016 College STAR, All Rights Reserved.

include_recipe 'apt'
include_recipe 'ruby_build'
include_recipe 'ruby_rbenv::user'
include_recipe 'nodejs'

# The paperclip gem depends on imagemagick
package 'imagemagick'

# The nokogiri gem has issues with libxml
# and we need to use the system library
# for libxml. Nokogiri documentation states
# that pkg-config is required to do this.
package 'pkg-config'

user = node['collegestar_org']['appserver']['user']
app_dir = node['collegestar_org']['appserver']['app_name']

template "/home/#{user}/#{app_dir}/config/application.yml" do
  source 'application.yml.erb'
  mode '644'
end

template '/etc/init.d/unicorn_collegestar_org' do
  source 'unicorn_collegestar_org.erb'
  mode '0755'
  owner 'root'
  group 'root'
  notifies :run, 'execute[bundler_nokogiri]'
  notifies :run, 'execute[bundler]'
  notifies :run, 'execute[unicorn_on_boot]'
  notifies :run, 'execute[unicorn_start]'
end

# Configure bundler to build nokogiri with 
# system libraries
execute 'bundler_nokogiri' do
   command "su vagrant -l -c 'cd /home/vagrant/collegestar_org && bash -i bundle config build.nokogiri --use-system-libraries'"
end

execute 'bundler' do
  command "su vagrant -l -c 'cd /home/vagrant/collegestar_org && bash -i bundle install'"
end

execute 'unicorn_on_boot' do
  command 'update-rc.d unicorn_collegestar_org defaults'
end

execute 'unicorn_start' do
  command 'service unicorn_collegestar_org start'
end
