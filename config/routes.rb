PoorPedia::Application.routes.draw do
  resources :users, only: [:new, :create, :show]

  resources :sessions

  resources :articles do
    member do
      get 'picture'
    end
  end

  root to: 'articles#index'

  match 'signup' => 'users#new'
  match 'signin' => 'sessions#new'
  match 'signout' => 'sessions#destroy', via: :delete

end