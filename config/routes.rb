Rails.application.routes.draw do
  resources :bookmarks
  root 'pages#home'
  get '/tables', to: 'bookmarks#tables'
end
