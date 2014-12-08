Rails.application.routes.draw do

  resources :users
  devise_for :users, :path => '', :path_names => {:sign_in => 'sign_in', :sign_out => 'sign_out', :sign_up => 'sign_up'},
                     :controllers => { :omniauth_callbacks => "callbacks" }
  
  resources :programs
<<<<<<< HEAD
  get '/add_to_google_calendar/' => 'programs#add_gcal_event'
  post '/add_to_google_calendar/' => 'programs#add_gcal_event'
  root 'static_pages#welcome'
=======
  resources :activities

  devise_scope :user do
    root "devise/sessions#new"
  end
>>>>>>> 7fe3f1bfaa63563f12d88dc0ef0256c3b923abb4

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
