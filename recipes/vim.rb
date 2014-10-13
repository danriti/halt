#
# Cookbook Name:: halt
# Recipe:: vim

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
