set :whenever_roles, :app

set :application, 'dlss-workgroup-external-service-integration'
set :repo_url, 'git@github.com:sul-dlss/dlss-workgroup-external-service-integration.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/opt/app/slack/dlss-workgroup-external-service-integration'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/confluence.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp vendor/bundle}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

end
