class Project < ApplicationRecord
  has_many :users, through: :development
  has_many :bugs, dependent: :destroy
end
