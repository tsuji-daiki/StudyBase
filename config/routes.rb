Rails.application.routes.draw do
  resources :posts
  resources :profiles, only: [:edit, :create, :update, :delete]
  get 'profiles', to: 'profiles#index'
  get 'profiles/:id', to: 'profiles#index'
  get 'studies', to: 'studies#index'
  get 'studies/:id', to: 'studies#index'
  post 'studies/:id', to: 'studies#create'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # ログアウト
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
