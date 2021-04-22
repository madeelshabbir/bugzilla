class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { developer: 0, manager: 1, qa: 2 }

  has_many :bugs, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :assigned_bugs, class_name: :Bug

  has_many :own_projects, class_name: :Project, dependent: :destroy

  scope :available, ->(ids) { where('user_type <> 1 AND id NOT IN (?)', ids) }
end
