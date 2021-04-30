class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { developer: 0, manager: 1, qa: 2 }

  USER_TYPE_MAP = {
    Developer: :developer,
    Manager: :manager,
    QA: :qa
  }.freeze

  has_many :bugs, dependent: :destroy, foreign_key: :creator_id, inverse_of: :creator
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :assigned_bugs, class_name: :Bug, dependent: :nullify, foreign_key: :assignee_id, inverse_of: :assignee

  has_many :created_projects, class_name: :Project, dependent: :destroy, foreign_key: :creator_id, inverse_of: :creator

  scope :unavailable, ->(project_id) { joins(:project_users).where('project_users.project_id = ?', project_id) }
  scope :available, ->(project_id) { where.not(user_type: 1, id: unavailable(project_id)) }
end
