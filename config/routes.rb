Rails.application.routes.draw do
  devise_for :users,  skip: :passwords,
                      path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :projects do
    resources :bugs
  end
end
