Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :job_offers
  root to: 'home#index'
end
