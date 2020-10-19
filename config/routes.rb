Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"
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
  get '/pets/:id', to: 'pets#show'
  get 'shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete 'pets/:id/delete', to: 'pets#destroy'

  # USER routes
  resources :users, only: [:show, :new, :create]
  # get '/users/:id', to: 'users#show'

  # REVIEWS ROUTES
  # resources :reviews, only: [:new, :create]
  get "/shelters/:shelter_id/reviews/new", to: 'reviews#new'
  post 'shelters/:shelter_id', to: 'reviews#create'
  get "/shelters/:shelter_id/reviews/:id/edit", to: 'reviews#edit'
  patch "/shelters/:shelter_id/reviews/:id", to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:id/delete', to: 'reviews#destroy'

  # APPLICATIONS
  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'
  post '/applications', to: 'applications#create'
  patch '/applications/:id', to: 'applications#update'

  # ADMIN
  get '/admin/applications/:id', to: 'admin#show'
  patch '/admin/application/:app_id/application_pets/:pet_id', to: 'admin#update'
end
