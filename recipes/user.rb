#
# Cookbook Name:: halt
# Recipe:: user

user "driti" do
  supports :manage_home => true
  comment "driti"
  home "/home/driti"
  shell "/bin/bash"
  action :create
end

group "ubuntu" do
  members ["ubuntu", "driti"]
end

node['halt']['home_directories'].each do |dir|
  directory "#{dir}" do
    owner 'driti'
    group 'driti'
  end
end
