Rails.application.routes.draw do
  devise_for :users,  path_names: { sign_in: 'login', sign_out: 'logout' },
                      controllers: { registrations: 'users/registrations' }

  resources :projects do
    resources :bugs
  end
end
