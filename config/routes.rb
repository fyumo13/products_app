Rails.application.routes.draw do
  root 'sessions#new'
  get '/sessions/new' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  delete '/sessions/:id' => 'sessions#destroy'
  post '/purchases' => 'purchases#create'
  delete '/purchases/:id' => 'purchases#destroy'
  post '/comments/:id' => 'comments#create'
  resources :users, :products
end
