ActionController::Routing::Routes.draw do |map|

  map.resources :image_shells, :has_many => [:images,:requests], :has_one => [:description], :as => :i
              
  map.resources :description
  map.resources :requests

  map.resources :payment_notifications
  map.resources :price_option_names
  map.resources :price_options
  map.resources :price_medias
  map.resources :price_usages
  map.resources :product_use_industries
  # OLD
  # map.resources :product_use_printruns
  # map.resources :product_use_sizes
  # map.resources :product_use_placements
  # map.resources :product_use_durations
  # map.resources :product_types
  # map.resources :product_categories

  map.resources :line_items
  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :purge     => :delete } do |users|
                                      # users.resources :images
                                      users.resources :invitations, :collection => { :edit_multiple => :get, :update_multiple => :put }
                                      # users.resources :proofs do |proofs|
                                      #   proofs.resources :masters
                                      # end
                                     end
  map.resource :session
  # map.resources :masters, :has_one => :description
  # map.resources :proofs, :has_one => :description
  
  map.resources :images, :has_many => :requests

  map.resources :carts
  map.resources :orders
  
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.signup '/signup', :controller => 'users', :action => 'new', :id => 'select'
  map.rider_signup '/rider-signup', :controller => 'users', :action => 'new', :id => 'rider'
  map.photographer_signup '/photographer-signup', :controller => 'users', :action => 'new', :id => 'photographer'
  map.consumer_signup '/consumer-signup', :controller => 'users', :action => 'new', :id => 'consumer'
  
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.dashboard '/dashboard', :controller => 'dashboard'
  map.calculator '/calculator/:id', :controller => 'calculator'
  map.calculator '/calculator/show/:id', :controller => 'calculator', :action => 'show'
  map.calculator '/calculator/getUseTypes/:id', :controller => 'calculator', :action => 'getUseTypes'
  map.calculator '/calculator/getUseOptions/:id/:owner', :controller => 'calculator', :action => 'getUseOptions'
  map.calculator '/calculator/calculate_price/:id/', :controller => 'calculator', :action => 'calculate_price'
  map.calculator '/calculator/add_to_cart/:id/', :controller => 'calculator', :action => 'add_to_cart'
  map.admin 'price_medias/:action/:id', :controller => 'price_medias'
  map.admin 'price_options/:action/:id/:type', :controller => 'price_options'
  map.cart 'cart', :controller => 'carts', :action => 'index'
  map.thankyou 'cart/thankyou', :controller => 'carts', :action => 'thankyou'
  map.about 'about/:action', :controller => 'about'
  
  map.root :controller => 'browse'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
