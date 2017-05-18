Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :gears, only: [:index, :show] do
    resources :orders, only: [:index, :create]
  end
  mount Attachinary::Engine => "/attachinary"
end
