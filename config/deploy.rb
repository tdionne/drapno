set :application, "drapno"
set :repository,  "git@github.com:jystewart/drapno.git"
set :rails_env, "staging"

set :deploy_to, "/var/www/#{rails_env}.#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :branch, "master"

role :app, "212.124.198.2"
role :web, "212.124.198.2"
role :db,  "212.124.198.2", :primary => true
