require "bundler/capistrano"
set :rvm_ruby_string, '2.0.0'
set :rvm_type, :user

#main details
set :application, "lu.uni.hpc"
set :scm_username, "passenger"
set :repository,  "https://github.com/tusha/lu.uni.hpc.git"
set :git_enable_submodules, 1
set :scm, :git 
set :branch, "master"
set :user, "localadmin"


role :web, "jshadobf.uni.lu" # Your HTTP server, Apache/etc
role :app, "jshadobf.uni.lu" # This may be the same as your `Web` server
role :db, :primary => true # This is where Rails migrations will run

#server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:port] = 8022
ssh_options[:keys] = '/home/katja/.ssh/id_rsa.pem'
set :deploy_to, "/srv/www/jshadobf.uni.lu/public_html"
set :deploy_via, :remote_cache
set :user, "localadmin"
set :use_sudo, true
set :default_stage, 'production'


# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end
  
  task :symlink_config_files do
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
 end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

namespace :bundler do
  desc "Symlink bundled gems on each release"
  task :symlink_bundled_gems, :roles => :app do
    run "mkdir -p #{shared_path}/bundled_gems"
    run "ln -nfs #{shared_path}/bundled_gems #{release_path}/vendor/bundle"
  end

  desc "Install for production"
  task :install, :roles => :app do
    run "cd #{release_path} && bundle install --production"
  end
  


end

after "deploy", "deploy:symlink_config_files"
#after 'deploy:update_code', 'bundler:install'
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end