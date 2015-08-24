Rails.application.routes.draw do
  root to: 'sessions#new'

  get 'register' => 'users#new'

  resources :users

  controller :sessions do
    get  'login'  => :new
    post 'login'  => :create
    get  'logout' => :destroy
  end

  resources :sessions, only: [:new, :create, :destroy]  do
    collection do
      get 'two_factor'
      post 'verify'
    end
  end

end
