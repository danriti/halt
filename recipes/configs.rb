#
# Cookbook Name:: halt
# Recipe:: configs

git "/home/driti/dev/configs" do
  repository "https://github.com/danriti/configs.git"
  revision "master"
  user "driti"
  group "driti"
end

node["halt"]["dot_files"].each do |file|
  remote_file "/home/driti/#{file[0]}" do
    source "file://#{file[1]}"
    user "driti"
    group "driti"
  end
end

execute "install bin scripts" do
  command "cp /home/driti/dev/configs/bin/* /home/driti/bin/"
end
