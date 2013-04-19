Shop::Application.routes.draw do

  devise_for :admins
  resources :admins

  devise_for :users

  root :to => 'welcome#index'
  match '' => 'welcome#index'
  match '/order' => 'goods#order'
  match '/order3' => 'goods#order3', :via => [:post]
  match '/request' => 'goods#request'

  match '/signup' => 'devise/registrations#new'
  match '/signin' => 'welcome#signin'
  match '/signout' => 'welcome#signout'

  get "welcome/index"

  get "welcome/show"

  #match '/users/:id/send' => 'users#delivery'
  match '/users/:id/prepare' => 'baskets#delivery_prepare'
  match '/users/:id/send' => 'baskets#delivery'
  match '/users/:id/basket' => 'users#basket',
    :requirements => { :id => /^\d+/ }
  match '/users/baskets' => 'users#baskets'
  match '/users/list' => 'baskets#request_list'
  match '/users/requests' => 'users#requests'

  match '/profile/basket' => 'baskets#items'
  match '/profile/request' => 'baskets#requested'
  match '/profile/history' => 'baskets#history'
  match '/profile/delivery' => 'baskets#items'
  match '/profile' => 'users#show'

  #	Конфликтует с маршрутом '/profile/basket'
  match '/baskets/items' => 'baskets#items'

  resources :baskets

  resources :goods

  resources :users
  
  #	Default route handler
  match '/*path' => 'welcome#error404'

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
