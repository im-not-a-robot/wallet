Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/auth', to: 'authentication#authenticate'
  post '/deposit', to: 'transaction#deposit'
  post '/withdraw', to: 'transaction#withdraw'
end
