Rails.application.routes.draw do
  root 'home#index'
  get '/about', to: 'home#about'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'trips/:id/users/:id', to: 'users#profile'
  get '/users/:id', to: 'users#show', :as => :user

  get 'trips/:id/invite/new' => 'users#invitation'
  post 'trips/:id/invite' => 'users#invited'

  resources :users, only: [:new, :create, :show]

  resources :trips, except: [:index] do
    resources :comments, except: [:index]
    resources :items, except: [:index] do
      resources :votes, except: [:index, :show]
    end
    resources :days, only: [:show]
    resources :user, only: [:show]
  end
end
