Rails.application.routes.draw do
  root "static#index"
  devise_for :users, :path => '', :path_names => {:sign_in => 'sign_in', :sign_out => 'sign_out', :sign_up => 'sign_up'}
  
  resources :users

  resources :programs
  resources :activities
  resources :logs, :index

  post 'activities/:id/tweet', to:'activities#tweet', as: 'tweet'
  post 'activities/:id/share', to:'activities#share', as: 'share'
  get 'activities/:id/create_event', to: 'activities#create_event', as: 'create_event'
  get 'activities/:id/create_gcal', to: 'activities#create_gcal', as: 'create_gcal'
  post 'activities/:id/send_mails', to: 'activities#send_mails', as: 'send_mails'

  match 'settings' => 'magicbeans#settings', via: [:get, :post], :as => :settings
  get 'settings/generate' => 'magicbeans#generate_page_token', :as => 'generate'

  scope '/api' do
    get '/programs/tags' => 'programs#get_all_tags'
    get '/activities/tags' => 'activities#get_all_tags'
  end
end
