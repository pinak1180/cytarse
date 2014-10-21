set :branch, 'master'
set :rails_env, 'production'
set :deploy_to, '/home/app/heliwm_production'

server '', user: 'app', roles: %w{web app db util}
