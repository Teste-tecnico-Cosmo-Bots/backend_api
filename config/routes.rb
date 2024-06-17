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

      # Comments
      get 'comments', to: 'comments#index'
      get 'comments/:id', to: 'comments#show'
      post 'comments', to: 'comments#create'
      patch 'comments/:id', to: 'comments#update'
      delete 'comments/:id', to: 'comments#destroy'

      # Posts
      get 'posts', to: 'posts#index'
      get 'posts/all', to: 'posts#get_with_comments'
      get 'posts/:id', to: 'posts#show'
      post 'posts', to: 'posts#create'
      patch 'posts/:id', to: 'posts#update'
      delete 'posts/:id', to: 'posts#destroy'

      # Users
      get 'users', to: 'users#index'
      get 'valid/token', to: 'users#validate_token'
      get 'users/:id', to: 'users#show'
      post 'users', to: 'users#create'
      patch 'users/:id', to: 'users#update'
      delete 'users/:id', to: 'users#destroy'

      
    end
  end
end
