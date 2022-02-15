Rails.application.routes.draw do
  resources :posts
  get 'profiles/:id', to: 'profiles#index'
  get 'profiles/:id', to: 'profiles#edit'
  get 'countdowns', to: 'countdowns#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
