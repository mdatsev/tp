Rails.application.routes.draw do
  resources :text_files
  match '/sum', :to => 'sum#form', :via => [:get]
  match '/sum', :to => 'sum#calc', :via => [:post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
