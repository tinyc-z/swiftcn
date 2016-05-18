Rails.application.routes.draw do

  devise_for :users, path: 'accounts', controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
  }

  root 'topics#index'
  
  get 'about' => 'pages#about'
  get 'jobs' => 'nodes#jobs'

  resources :nodes, only: [:show]

  resources :topics do 
    member do
      post :toggle_up_vote

      put :toggle_recomend
      put :toggle_wiki
      put :toggle_pin
      put :toggle_sink
    end

    resources :appends, only: [:create]

    resources :favorits do
      post :toggle_favorit, on: :collection
    end

    resources :attentions do
      post :toggle_attention, on: :collection
    end

  end


  resources :replies,only:[:create,:destroy] do 
    member do
      post :toggle_up_vote
    end
  end

  resources :users do 
    member do
      post :ban
      post :free

      get :calendar

      get :replies
      get :topics
      get :favorites
    end
  end

  resources :notifications, only:[:index]

  

  require 'sidekiq/web'
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
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
