Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end
  
  get 'pages/home'
  devise_for :users
  get "user/:id", to: "users#show", as: "user"

  root "pages#home"
end
