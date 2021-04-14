class Project < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :bugs, dependent: :destroy
end
