Rails.application.routes.draw do

  resources :wills do
    get 'final_will'
    resources :testator_details, only: [:new, :edit, :create, :update]
    resources :partner_details, only: [:new, :edit, :create, :update]
    resources :funerals, only: [:new, :edit, :create, :update]
    resources :executors, only: [:new, :edit, :create, :update] do

        get :first_executor
        get :second_executor
        get :third_executor
        get :forth_executor
        get :first_replacement_executor
        get :second_replacement_executor
        get :third_replacement_executor
        get :forth_replacement_executor

    end
    resources :administrations, only: [:new, :edit, :create, :update]
    resources :guardians, only: [:new, :edit, :create, :update] do

        get :option
        get :first_guardian
        get :second_guardian
        get :third_guardian
        get :forth_guardian
        get :first_replacement_guardian
        get :second_replacement_guardian
        get :third_replacement_guardian
        get :forth_replacement_guardian

    end
    resources :cash_gifts, only: [:new, :edit, :create, :update, :index] do
      collection { get :option }
    end
    resources :charitable_donations, only: [:new, :edit, :create, :update, :index] do
      collection { get :option }
    end
    resources :charity_permissions, only: [:new, :edit, :create, :update]
    resources :properties, only: [:new, :edit, :create, :update, :index] do
      collection { get :option }
      get :benificiaries
    end
    resources :personal_gifts, only: [:new, :edit, :create, :update, :index] do
      collection { get :option }
    end
    resources :residuaries, only: [:new, :edit, :create, :update]
    resources :residuary_details, only: [:new, :edit, :create, :update, :index] do
        get :charity_benificiary
        get :people_benificiary 
        collection do 
          get :secondary
          get :option
        end
    end
    resources :requests, only: [:new, :edit, :create, :update]
  end

  resources :general_details, only: [:new, :edit, :create, :update]
  resources :questions

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/terms_and_conditions', to: 'static_pages#terms_and_conditions', via: 'get'

  root 'static_pages#home'



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
