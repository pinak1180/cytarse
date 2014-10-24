set :branch, 'feature/stripe'
set :rails_env, 'production'
set :deploy_to, '/home/app/heliwm_staging'

server '178.62.109.10', user: 'app', roles: %w{web app db util}
