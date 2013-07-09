VenShop::Application.routes.draw do
  root to: 'home_page#home'
  
  match '/carts/pay', to: 'carts#pay', as: "pay_cart"
  resources :user
  resources :sessions, only: [:new, :create, :destroy]
  resources :products
  resources :categories
  resources :carts
  #get "user/new"

  match '/carts/new/:id' , to: 'carts#new', as: "new_cart"
  match '/login',    to: 'sessions#new'
  match '/logout', to: 'sessions#destroy', via: :delete
  match '/register',   to: 'user#new'
  match '/user/new', to: 'user#create'
  match '/products/list', to: 'products#index'
  match '/products/new', to: 'products#create'
  match '/products', to: 'products#destroy', via: :delete
  match '/carts/new', to: 'carts#create', via: :post, as: "create_cart"
  match '/carts/show', to: 'user#show'
  match '/carts/empty/:id', to: 'carts#empty', as: "empty_cart"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
