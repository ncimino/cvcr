Cvcr::Application.routes.draw do

  root :to => 'pages#show', :id => 0

  match '/auth/failure' => 'authentications#failure'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/pages/:id' => 'pages#show', :as => :page
  match '/sections/:id' => 'sections#show', :as => :section
  match '/products/:id' => 'products#show', :as => :product
  match '/products' => 'products#index'
  match '/drinks' => 'sections#drinks'
  match '/contact' => 'sections#contact'
  match '/events' => 'sections#events'

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
