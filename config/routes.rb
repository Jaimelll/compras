Rails.application.routes.draw do



  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin/dashboard#index'

  namespace :admin do
    resources :products do
      resources :formulas
    end
  end

  namespace :admin do
      resources :items do
        resources :details
      end
    end




end
