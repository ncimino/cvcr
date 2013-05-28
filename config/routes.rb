Cvcr::Application.routes.draw do

  root :to => 'pages#show', :id => 0

  match '/auth/failure' => 'authentications#failure'
  match '/auth/:provider/callback' => 'authentications#create'
  match 'pages/:id' => 'pages#show', :as => :page

  #resources :pages

  get 'sessions/new'
  get 'registrations/edit'
  get 'registrations/new'
  get 'authentications/index'
  get 'authentications/create'
  get 'authentications/destroy'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => {:registrations => 'registrations'}

end
