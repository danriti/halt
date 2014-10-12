#
# Cookbook Name:: halt
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# Packages
# ---------------------
package 'ubuntu-desktop'
package 'ssh'
package 'vim'
package 'vim-gnome'
package 'tmux'
package 'git'
package 'firefox'
package 'i3'
package 'scrot'
package 'feh'
package 'rxvt-unicode-256color'
package 'xfonts-terminus'

include_recipe 'google-chrome'


# User Land
# ---------------------
user "driti" do
  supports :manage_home => true
  home "/home/driti"
  shell "/bin/bash"
  system true
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

git "/home/driti/dev/config" do
  repository "https://github.com/danriti/configs.git"
  revision "master"
  user "driti"
  group "driti"
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


# Development
# ---------------------

# python / virtualenv
# py3k
# nvm
# rvm
# gvm
# heroku-toolbelt
# hub

# vim plugins - https://supermarket.getchef.com/cookbooks/vim_config
# - pathogen or vundle
