Rails.application.routes.draw do

#  get 'welcome/index'
#  root 'welcome#index'
root 'posts#index'

  devise_for :users, shallow: true

  resources :posts do
    get :my, on: :collection
    get :drafts, on: :collection
    get :moderation, on: :collection
    get :published, on: :collection

    patch :publish, on: :member
    patch :to_moderation, on: :member
    patch :to_draft, on: :member

    resources :comments, shallow: true
    resources :subscriptions, only: [:create, :destroy], shallow: true
  end

  resources :categories, only: [:show]
  resources :tags

  namespace :admin do
    resources :categories
    resources :users, only: [:index, :destroy]
  end

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
