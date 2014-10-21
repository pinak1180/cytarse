set :branch, 'master'
set :rails_env, 'production'
set :deploy_to, '/home/app/heliwm_staging'

server '178.62.111.213', user: 'app', roles: %w{web app db util}
