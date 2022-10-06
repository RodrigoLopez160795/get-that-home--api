Rails.application.routes.draw do
  resources "saved_properties", only: %i[index create show update destroy]
  resources "properties"
  resources "users", except: %i[index show update destroy]
  get "/profile", to: "users#show"
  patch "/profile", to: "users#update"
  delete "/profile", to: "users#destroy"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # get 'users/mario'
  # get 'users/show'
  # get 'users/create'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
