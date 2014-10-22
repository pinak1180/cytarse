# config valid only for Capistrano 3.2
lock '3.2.1'

set :application, 'heliwm'
set :repo_url, 'git@github.com:meigwilym/cytarse.git'

set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :linked_files, []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :keep_releases, 5
set :ssh_options, {:forward_agent => true}

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
  desc 'Start sidekiq'
  task :start do
    on roles(:util) do
      sudo 'service sidekiq start'
    end
  end

  desc 'Stop sidekiq'
  task :stop do
    on roles(:util) do
      sudo 'service sidekiq stop'
    end
  end

  desc 'Restart sidekiq'
  task :restart do
    on roles(:util) do
      sudo 'service sidekiq restart'
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
