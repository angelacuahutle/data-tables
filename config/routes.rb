Rails.application.routes.draw do
  resources :bookmarks do
    get 'export_csv', on: :collection, defaults: { format: :csv }
  end
  root 'pages#home'

  get '/tables', to: 'bookmarks#tables'

  get '/modal', to: 'pages#modal'
  get '/modal_content', to: 'pages#modal_content'


end
