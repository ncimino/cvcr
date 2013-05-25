Cvcr::Application.routes.draw do

  get "registrations/edit"

  get "registrations/new"

  get "authentications/index"

  get "authentications/create"

  get "authentications/destroy"

  match '/auth/failure' => 'authentications#failure'
  match '/auth/:provider/callback' => 'authentications#create'
  
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {:registrations => 'registrations'}

  root :to => 'pages#show', :id => 0
  get 'sessions/new'
#   resources :pages
  match 'pages/:id' => 'pages#show', :as => :page

  ActiveAdmin.routes(self)
end
