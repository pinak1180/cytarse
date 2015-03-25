require 'sidekiq/web'

Catarse::Application.routes.draw do

  if ENV['MAIL_METHOD'] == 'letter_opener_web'
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  mount RedactorRails::Engine => '/redactor_rails'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  devise_for :users, path: '',
    path_names:   { sign_in: :mewngofnodi, sign_out: :allgofnodi, sign_up: :ymuno },
    controllers:  { omniauth_callbacks: :omniauth_callbacks, passwords: :passwords }


  devise_scope :user do
    post '/ymuno', to: 'devise/registrations#create', as: :sign_up
  end


  get '/diolch' => "static#thank_you"

  filter :locale, exclude: /\/auth\//

  #mount CatarsePaypalExpress::Engine => "/", as: :catarse_paypal_express
  #mount CatarseBraintree::Engine => "/", as: :catarse_braintree
  #mount CatarseMoip::Engine => "/", as: :catarse_moip
  mount CatarseStripe::Engine => "/", :as => "catarse_stripe"


  # Static Pages
  get '/sitemap',               to: 'static#sitemap',             as: :sitemap
  get '/canllaw', 	        to: 'static#guidelines',          as: :guidelines
  get "/canllaw_tips",          to: "static#guidelines_tips",     as: :guidelines_tips
  get "/canllawn_backers",      to: "static#guidelines_backers",  as: :guidelines_backers
  get "/canllaw_dechrau",       to: "static#guidelines_start",    as: :guidelines_start
  get "/holi",                  to: "static#faq", as: :faq_page
  get "/contact",               to: "static#contact", as: :contact_page

  # static t&cs, contact
  get "/termau", to: 'static#terms', as: :terms
  get "/cyswllt", to: 'static#contact', as: :contact

  get "/darganfod" => "explore#index", as: :explore

  get '/post_preview' => 'post_preview#show', as: :post_preview
  resources :categories, only: [] do
    member do
      get :subscribe, to: 'categories/subscriptions#create'
      get :unsubscribe, to: 'categories/subscriptions#destroy'
    end
  end
  resources :auto_complete_projects, only: [:index]
  resources :projects, only: [:index, :create, :update, :edit, :new, :show] do
    resources :accounts, only: [:create, :update]
    resources :posts, controller: 'projects/posts', only: [ :index, :destroy ]
    resources :rewards, only: [ :index ] do
      post :sort, on: :member
    end
    resources :contributions, {controller: 'projects/contributions'} do
      put :credits_checkout, on: :member
    end

    get 'video', on: :collection
    member do
      get :reminder, to: 'projects/reminders#create'
      delete :reminder, to: 'projects/reminders#destroy'
      get :metrics, to: 'projects/metrics#index'
      put 'pay'
      get 'embed'
      get 'video_embed'
      get 'about_mobile'
      get 'embed_panel'
      get 'send_to_analysis'
      get 'publish'
    end
  end
  resources :users do
    resources :credit_cards, controller: 'users/credit_cards', only: [ :destroy ]
    member do
      get :unsubscribe_notifications
      get :credits
      get :settings
      get :reactivate
    end

    resources :unsubscribes, only: [:create]
    member do
      get 'projects'
      put 'unsubscribe_update'
      put 'update_email'
      put 'update_password'
    end
  end

  get "/terms-of-use" => 'high_voltage/pages#show', id: 'terms_of_use'
  get "/privacy-policy" => 'high_voltage/pages#show', id: 'privacy_policy'
  get "/start" => 'high_voltage/pages#show', id: 'start'
  get "/jobs" => 'high_voltage/pages#show', id: 'jobs'
  get "/assets" => 'high_voltage/pages#show', id: 'assets'
  get "/guides" => 'high_voltage/pages#show', id: 'guides', as: :guides



  # User permalink profile
  constraints SubdomainConstraint do
    get "/", to: 'users#show'
  end

  # Root path should be after channel constraints
  root to: 'projects#index'

  namespace :reports do
    resources :contribution_reports_for_project_owners, only: [:index]
  end

  # Feedback form
  resources :feedbacks, only: [:create]

  namespace :admin do

    # Sidekiq
    check_user_admin = lambda { |request| request.env["warden"].authenticate? and request.env['warden'].user.admin }
    constraints check_user_admin do
      mount Sidekiq::Web => 'sidekiq'
    end

    resources :projects, only: [ :index, :update, :destroy ] do
      member do
        put 'approve'
        put 'push_to_online'
        put 'reject'
        put 'push_to_draft'
        put 'push_to_trash'
      end
    end

    resources :statistics, only: [ :index ]
    resources :financials, only: [ :index ]

    resources :contributions, only: [ :index, :update, :show ] do
      member do
        get :second_slip
        put 'confirm'
        put 'pendent'
        put 'change_reward'
        put 'refund'
        put 'hide'
        put 'cancel'
        put 'request_refund'
        put 'push_to_trash'
      end
    end
    resources :users, only: [ :index ]

    namespace :reports do
      resources :contribution_reports, only: [ :index ]
    end
  end

  get "/:permalink" => "projects#show", as: :project_by_slug

end
