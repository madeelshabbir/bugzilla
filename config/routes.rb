Rails.application.routes.draw do
  devise_for :users,  path_names: { sign_in: 'login', sign_out: 'logout' },
                      controllers: { registrations: 'users/registrations' }

  resources :projects do
    post 'add_member', action: :add_member, controller: 'developments', as: 'add_member'
    delete 'delete_member/:id', action: :delete_member, controller: 'developments', as: 'delete_member'
    resources :bugs
  end
end
