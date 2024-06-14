Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # Rotas para usuários (Devise)
      devise_for :users,
      path: '',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }

       # Rotas para Comments
       resources :comments, only: [:index, :show, :create, :update, :destroy]

       # Rotas para Posts
       resources :posts, only: [:index, :show, :create, :update, :destroy]
 
       # Rotas para Users
       resources :users, only: [:index, :show, :create, :update, :destroy]
    #  # Comments
    #  get 'comments', to: 'comments#index'
    #  get 'comments/:id', to: 'comments#show'
    #  post 'comments', to: 'comments#create'
    #  patch 'comments/:id', to: 'comments#update'
    #  delete 'comments/:id', to: 'comments#destroy'

    #  # Posts
    #  get 'posts', to: 'posts#index'
    #  get 'posts/:id', to: 'posts#show'
    #  post 'posts', to: 'posts#create'
    #  patch 'posts/:id', to: 'posts#update'
    #  delete 'posts/:id', to: 'posts#destroy'

    #  # Users
    #  get 'users', to: 'users#index'
    #  get 'users/:id', to: 'users#show'
    #  post 'users', to: 'users#create'
    #  patch 'users/:id', to: 'users#update'
    #  delete 'users/:id', to: 'users#destroy'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
