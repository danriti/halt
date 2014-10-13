#
# Cookbook Name:: halt
# Recipe:: tools

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
