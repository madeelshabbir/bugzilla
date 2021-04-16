class Project < ApplicationRecord
  has_many :developments, dependent: :nullify
  has_many :users, through: :developments
  has_many :bugs, dependent: :destroy
end
