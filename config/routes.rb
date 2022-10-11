Rails.application.routes.draw do
  resources "saved_properties", only: %i[create show update destroy]
  resources "properties"
  resources "users", except: %i[index show update destroy]
  get "/profile", to: "users#show"
  patch "/profile", to: "users#update"
  delete "/profile", to: "users#destroy"
  get "/myproperties", to: "properties#my_properties"
  get "/mysavedproperties", to: "saved_properties#my_saved_properties"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
