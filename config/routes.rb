Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # SHELTERS ROUTES
  get '/shelters', to: 'shelters#index'
  get 'shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get 'shelters/:id/pets', to: 'shelters#pets'

  # PETS ROUTES
  get '/pets', to: 'pets#index'
end
