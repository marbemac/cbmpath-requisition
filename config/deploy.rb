require 'bundler/capistrano'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :rack_env, "production"
set :domain, '198.211.108.223'
set :application, 'cbmpath-requisition'
set :repository,  'git://github.com/marbemac/cbmpath-requisition.git'
set :branch,  'master'
set :deploy_to, "/var/www/#{application}"

set :scm, :git
set :scm_verbose, true

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_via, :remote_cache
set :use_sudo, false
set :keep_releases, 3
set :user, 'root'

set :bundle_without, [:development, :test]

set :default_environment, {
    'PATH' => "/usr/local/rvm/gems/ruby-2.0.0-p0@CBMPathRequisition/bin:/usr/local/rvm/gems/ruby-2.0.0-p0@global/bin:/usr/local/rvm/rubies/ruby-2.0.0-p0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
    'RUBY_VERSION' => 'ruby 2.0.0',
    'GEM_HOME'     => '/usr/local/rvm/gems/ruby-2.0.0-p0@CBMPathRequisition',
    'GEM_PATH'     => '/usr/local/rvm/gems/ruby-2.0.0-p0@CBMPathRequisition:/usr/local/rvm/gems/ruby-2.0.0-p0@global',
    'BUNDLE_PATH'  => '/usr/local/rvm/gems/ruby-2.0.0-p0@CBMPathRequisition'  # If you are using bundler.
}

namespace :deploy do
  desc "Restart Passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "update permissions"
  task :update_permissions, :roles => :app do
    run "cd #{release_path} && chmod -R 777 tmp"
  end
end

after 'deploy:setup' do
  sudo "chown -R #{user} #{deploy_to} && chmod -R g+s #{deploy_to}"
end
after "deploy:update_code", "deploy:update_permissions"