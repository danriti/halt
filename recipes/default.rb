#
# Cookbook Name:: halt
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# Packages
# ---------------------
package 'make' 
package 'binutils' 
package 'bison' 
package 'gcc' 
package 'build-essential'
package 'curl'
package 'ubuntu-desktop'
package 'python'
package 'python-virtualenv'
package 'python3'
package 'ruby'
package 'ssh'
package 'vim'
package 'vim-gnome'
package 'tmux'
package 'git'
package 'mercurial'
package 'firefox'
package 'i3'
package 'scrot'
package 'feh'
package 'meld'
package 'rxvt-unicode-256color'
package 'xfonts-terminus'

include_recipe 'google-chrome'


# User Land
# ---------------------
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


# Configs
# ---------------------
git "/home/driti/dev/config" do
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


# VIM
# ---------------------
node['halt']['pathogen_directories'].each do |dir|
  directory "#{dir}" do
    owner 'driti'
    group 'driti'
  end
end

remote_file "/home/driti/.vimrc" do
  source "file:///home/driti/dev/config/.vimrc"
  user "driti"
  group "driti"
end

remote_file "/home/driti/.vim/autoload/pathogen.vim" do
  source "https://tpo.pe/pathogen.vim"
  user "driti"
  group "driti"
end

node["halt"]["vim_plugins"].each do |plugin|
  git "/home/driti/.vim/bundle/#{plugin[0]}" do
    repository "#{plugin[1]}"
    revision "master"
    user "driti"
    group "driti"
  end
end


# Development Tools
# ---------------------
nvm_install_path = "/home/driti/.nvm"
bash "install nvm" do
  user "driti"
  group "driti"
  cwd "/home/driti/tmp"
  code <<-EOH
    git clone https://github.com/creationix/nvm.git #{nvm_install_path}
    cd #{nvm_install_path}
    git checkout `git describe --abbrev=0 --tags`
    EOH
  not_if { ::File.exists?(nvm_install_path) }
end

rvm_install_path = "/home/driti/.rvm"
bash "install rvm" do
  user "driti"
  group "driti"
  cwd "/home/driti/tmp"
  code <<-EOH
    curl -L https://get.rvm.io | bash -s stable --autolibs=enabled --path #{rvm_install_path}
    EOH
  not_if { ::File.exists?(rvm_install_path) }
end

gvm_install_path = "/home/driti/.gvm"
gvm_script_url = "https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer"
bash "install gvm" do
  user "driti"
  cwd "/home/driti/tmp"
  environment 'GVM_NO_UPDATE_PROFILE' => 1
  code <<-EOH
    curl -s -S -L #{gvm_script_url} | bash -s master #{gvm_install_path}
    EOH
  not_if { ::File.exists?(gvm_install_path) }
end

execute "install heroku toolbelt" do
  command "wget -qO- https://toolbelt.heroku.com/install.sh | sh"
  action :run
  not_if { ::File.exists?("/usr/local/heroku/bin/heroku") }
end
