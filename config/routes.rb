Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/search', to: "weather#search"
  # Defines the root path route ("/")
  root "weather#index"
end
