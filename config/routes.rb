Rails.application.routes.draw do




  resources :agreements
  resources :experiences
  resources :students
  resources :families
  resources :employees
  resources :elements
  resources :packages
  resources :contracts

  resources :pieces
  devise_for :admin_users, ActiveAdmin::Devise.config

    ActiveAdmin.routes(self)
#  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#admin_dashboard_path


concern :detalles do
    resources :details
end




namespace :admin do
  resources :phases do
    resources :activities
  end
end

  namespace :admin do
    resources :products do
      resources :formulas
    end
  end


 namespace :admin do

      resources :items, concerns: :detalles

  end

#root 'admin/employees#index', via: [:get]

root 'admin/dashboard#index'



match 'reports/comment', via: [:get]
match 'reports/comment2', via: [:get]
match 'reports/comment3', via: [:get]
match 'reports/comment4', via: [:get]
match 'reports/comment5', via: [:get]
match 'reports/comment6', via: [:get]
match 'reports/comment7', via: [:get]
match 'reports/vhoja1', via: [:get]
match 'reports/vhoja2', via: [:get]
match 'reports/vhoja3', via: [:get]
match 'reports/vhoja5', via: [:get]
match 'reports/vhoja6', via: [:get]



end
