PoorPedia::Application.routes.draw do
  resources :users
  resources :articles do
    member do
      get 'picture'
    end
  end

  root to: 'articles#index'
end