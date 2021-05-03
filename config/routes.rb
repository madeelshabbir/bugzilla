# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,  path_names: { sign_in: 'login', sign_out: 'logout' },
                      controllers: { registrations: 'users/registrations' }

  root 'projects#index'

  resources :projects do
    resources :project_users, only: %i[create destroy]
    resources :bugs
  end

  get ':not_active_storage',
      to: redirect('/'),
      constraints: { not_active_storage: %r{(?!rails/active_storage/blobs).*} }
end
