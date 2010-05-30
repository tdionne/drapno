require 'capistrano/ext/multistage'
require 'delayed/recipes'

set :default_stage, "staging"

set :application, "drapno"
set :repository,  "git@github.com:jystewart/drapno.git"
set :user, "drapno"

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

after "deploy:start", "delayed_job:start" 
after "deploy:stop", "delayed_job:stop" 
after "deploy:restart", "delayed_job:restart" 

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
  
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && /opt/ruby-enterprise/bin/bundle install --relock"
  end
  
  task :lock, :roles => :app do
    run "cd #{current_release} && /opt/ruby-enterprise/bin/bundle lock;"
  end
  
  task :unlock, :roles => :app do
    run "cd #{current_release} && /opt/ruby-enterprise/bin/bundle unlock;"
  end
end

after 'deploy:finalize_update', "link_config"
after "deploy:update_code", "bundler:bundle_new_release"