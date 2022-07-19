Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end
  
  devise_for :users, controllers: { registrations: "users/registrations" }

  get 'pages/home'
  get "user/:id", to: "users#show", as: "user"

  root "rooms#index"
end
