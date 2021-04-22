class Project < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :bugs, dependent: :destroy

  belongs_to :creator, class_name: :User, foreign_key: :user_id, inverse_of: :own_projects

  validates :title, uniqueness: { case_sensitive: false }
end
