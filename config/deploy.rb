require 'capistrano/ext/multistage'
require 'delayed/recipes'
require 'bundler/capistrano'

set :bundle_cmd, "/usr/local/bin/bundle"

set :default_stage, "staging"

set :application, "drapno"
set :repository,  "git@github.com:jystewart/drapno.git"
set :user, "drapno"

set :use_sudo, false
set :deploy_via, :remote_cache

set :ssh_options, { :forward_agent => true }
 
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

after "deploy:start", "delayed_job:start" 
after "deploy:stop", "delayed_job:stop" 
after "deploy:restart", "delayed_job:restart" 

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:finalize_update', "link_config"
