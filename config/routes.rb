Rails.application.routes.draw do
  devise_for :users,  path_names: { sign_in: 'login', sign_out: 'logout' },
                      controllers: { registrations: 'users/registrations' }

  root 'projects#index'

  resources :projects do
    post 'add_user', action: :add_user, controller: 'project_users', as: 'add_user'
    delete 'remove_user/:id', action: :remove_user, controller: 'project_users', as: 'remove_user'
    resources :bugs
  end

  get ':not_active_storage', to: redirect('/'), constraints: { not_active_storage: /(?!rails\/active_storage\/blobs).*/ }
end
