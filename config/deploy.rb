# config valid only for Capistrano 3.2
lock '3.2.1'

set :application, 'heliwm'
set :repo_url, 'git@github.com:meigwilym/cytarse.git'

set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :linked_files, []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :ssh_options, {:forward_agent => true}
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

SSHKit.config.command_map.prefix[:rake].unshift('source /etc/profile.d/app_env.sh; ')

namespace :db do
  desc 'Seed the DB'
  task :seed do
    on roles(:db) do
      within current_path do
        execute :rake, 'db:seed'
      end
    end
  end
end

namespace :sidekiq do
  desc 'Status sidekiq'
  task :status do
    on roles(:util) do
      execute '/sbin/status sidekiq'
    end
  end

  desc 'Start sidekiq'
  task :start do
    on roles(:util) do
      execute '/sbin/start sidekiq'
    end
  end

  desc 'Restart or start sidekiq'
  task :restart do
    on roles(:util) do
      execute '/sbin/restart sidekiq || /sbin/start sidekiq'
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'sidekiq:restart'

    on roles(:app), in: :sequence, wait: 5 do
      execute "touch #{File.join(current_path,'tmp','restart.txt')}"
    end
  end

  after :publishing, :restart
end
