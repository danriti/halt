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


# Development
# ---------------------

# python / virtualenv
# py3k
# nvm
# rvm
# gvm
# heroku-toolbelt
# hub
