Rails.application.routes.draw do
  devise_for :users
    resources "saved_properties", only: %i[index create show update destroy]
  resources "properties"
  resources "users", except: %i[index]
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
