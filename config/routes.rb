FamilyMe::Application.routes.draw do

  scope "(:locale)", locale: /en|fr/ do
    devise_for :users, :controllers => {
      :sessions => 'sessions',
      :registrations => 'registrations',
      :omniauth_callbacks => "users/omniauth_callbacks"
    }

    match '/icalendar' => 'families#icalendar', as: 'icalendar_events'

    resource :family, only: [:show, :create, :update, :new]
    resources :users, only: [:index]
    resources :invitations, only: [:index, :new, :create] do
      member do
        get 'accept'
        get 'reject'
      end
    end

    root :to => 'families#landing'
  end

  match '/posts' => 'families#show', :as => :dashboard, disable_redirect: true
  match '/posts/*page' => 'families#show', disable_redirect: true

  match '/todos' => 'families#show', disable_redirect: true
  match '/todos/*page' => 'families#show', disable_redirect: true

  match '/positions' => 'families#show', disable_redirect: true
  match '/positions/*page' => 'families#show', disable_redirect: true

  match '/events' => 'families#show', disable_redirect: true
  match '/events/*page' => 'families#show', disable_redirect: true


  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resource :family, only: :show
      resources :users, only: :index
      resources :positions, only: [:create, :index] do
        collection do
          get 'latest'
        end
      end
      resources :posts, only: [:create, :destroy, :index, :show, :update]

      resources :invitations, only: [:create, :index] do
        collection do
          get 'received'
        end
        member do
          get 'accept'
          get 'reject'
        end
      end

      resources :task_lists, only: [:create, :update, :destroy, :show, :index] do
        resources :tasks, only: [:create, :update, :destroy, :show, :index] do
          member do
            get 'finish'
          end
        end
      end

      resources :events, only: [:create, :destroy, :index, :show, :update] do
        collection do
          get 'currents' # list currents and futures
        end
      end
    end
  end
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
