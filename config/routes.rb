Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sub_categories#index'

  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get    'bids/user' => 'bids#user', as: 'user_bids'

  resources :listings do
    get 'user', on: :collection
    get 'user_show', on: :member
    resources :images, shallow: true
    resources :bids, shallow: true
    resources :questions, only: [:new, :create] 
  end
  resources :categories do
    resource :sub_category, only: [:new, :create]
  end
  resources :sub_categories, only: [:index, :destroy] do
    get 'listings' => 'listings#subcategory'
    get 'expired_listings' => 'expired_listings#subcategory'
  end
  resources :users
  resources :questions, only: [:edit, :update, :destroy] do
    resources :answers, shallow: true
  end
  resources :expired_listings, only: :index do
    get 'user', on: :collection
    post 'mark_as_sold', on: :member
  end





  
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
