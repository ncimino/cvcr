Cvcr::Application.routes.draw do

  #resources :payment_notifications, :line_items, :carts, :sessions

  root :to => 'pages#show', :id => 0

  match '/auth/failure' => 'authentications#failure'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/pages/:id' => 'pages#show', :as => :page
  match '/products/:id' => 'products#show', :as => :product
  match '/sections/:id' => 'sections#show', :as => :section
  match '/areas/:id' => 'main_areas#show', :as => :main_area
  match '/payment_notifications' => 'payment_notifications#create'
  match '/line_items' => 'line_items#create'
  match '/line_items/:id/increment' => 'line_items#increment'
  match '/line_items/:id/decrement' => 'line_items#decrement'
  match '/line_items/:id/destroy' => 'line_items#destroy'
  match '/cart' => 'carts#show'
  match '/cart/new' => 'carts#destroy'
  #match '/cart' => 'carts#show'

  match '/test' => 'test#show'

  get 'sessions/new'
  #get 'registrations/edit'
  #get 'registrations/new'
  #get 'authentications/index'
  #get 'authentications/create'
  #get 'authentications/destroy'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => {:registrations => 'registrations'}

end
