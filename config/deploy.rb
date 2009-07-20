set :application, "drapno"
set :repository,  "git@github.com:jystewart/drapno.git"
set :rails_env, "staging"
set :user, "drapno"

set :deploy_to, "/var/www/#{rails_env}.#{application}"
set :use_sudo, false
set :deploy_via, :remote_cache

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :branch, "master"

role :app, "212.124.198.2"
role :web, "212.124.198.2"
role :db,  "212.124.198.2", :primary => true

desc "Link in the production configuration"
task :link_config do
  run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
end

# add this to config/deploy.rb
namespace :delayed_job do
  desc "Start delayed_job process" 
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start" 
  end

  desc "Stop delayed_job process" 
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop" 
  end

  desc "Restart delayed_job process" 
  task :restart, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job restart" 
  end
end

after "deploy:start", "delayed_job:start" 
after "deploy:stop", "delayed_job:stop" 
after "deploy:restart", "delayed_job:restart" 

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:symlink', "link_config"
