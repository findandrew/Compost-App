Rails.application.routes.draw do

  # Lots of Info here: http://guides.rubyonrails.org/routing.html

  root				'static_pages#Home'

  # This syntax yields two named routes, ie. about_url (an
  # absolute path) and about_path (a relative path)

  get 'about'		=>	'static_pages#About'
  get 'faq'		=>	'static_pages#Faq'
  get 'partners'	=>	'static_pages#Partners'
  get 'pricing'		=>	'static_pages#Pricing'
  get 'contact'		=>	'static_pages#Contact'
  get 'terms'		=>	'static_pages#Terms'
  get 'signup'		=>	'users#new'
  get 'style'		=>	'static_pages#Style'
  get 'style2'		=>	'static_pages#Style2'

  # Sessions Routing

  get		'login'		=>	'sessions#new'
  post		'login'		=>	'sessions#create'
  delete	'logout'	=>	'sessions#destroy'

  # Resources, REST methods needed

  resources	:users do
    resources	  :members
    resources     :weights
  end
  resources	:account_activations, 	only: [:edit]
  resources	:password_resets,	only: [:new, :create, :edit, :update]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
