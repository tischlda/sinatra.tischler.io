require './config/capistrano_mongoid'

#========================
#CONFIG
#========================
set :application, "tischler.io"
set :scm, :git
set :git_enable_submodules, 1
set :repository, "https://github.com/tischlda/tischler.io.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
set :user, "deploy"
set :use_sudo, false
set :runner, "deploy"
set :deploy_to, "/srv/www/#{application}"
set :app_server, :passenger
set :domain, "tischler.io"

#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true

#========================
#CUSTOM
#========================
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"

  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end