Rails.application.routes.draw do
  resources :users

  get 'register' => 'users#new'

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
