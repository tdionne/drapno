set :rails_env, "staging"
set :deploy_to, "/var/www/#{rails_env}.#{application}"