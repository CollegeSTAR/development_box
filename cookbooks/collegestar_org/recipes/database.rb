#
# Cookbook Name:: collegestar_org
# Recipe:: database
#
# Copyright (c) 2016 College STAR, All Rights Reserved.

include_recipe 'apt'
include_recipe 'postgresql::server'
include_recipe 'database::postgresql'

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :port     => 5432,
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

#create web user
postgresql_database_user 'web' do
  connection postgresql_connection_info
  password node['postgresql']['password']['web']
  createdb true
  action :create
end
