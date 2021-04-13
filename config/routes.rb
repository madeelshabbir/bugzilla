Rails.application.routes.draw do
  devise_for :users,  skip: :passwords,
                      path_names: { sign_in: 'login', sign_out: 'logout' }

  # devise_scope :user do
  #   root 'devise/sessions#new'
  # end
end
