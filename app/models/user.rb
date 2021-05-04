# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  USER_TYPE_MAP = {
    Developer: :developer,
    Manager: :manager,
    QA: :qa
  }.freeze

  enum user_type: { developer: 0, manager: 1, qa: 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bugs, dependent: :destroy, foreign_key: :creator_id, inverse_of: :creator
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :assigned_bugs, class_name: :Bug, dependent: :nullify, foreign_key: :assignee_id, inverse_of: :assignee
  has_many :created_projects, class_name: :Project, dependent: :destroy, foreign_key: :creator_id, inverse_of: :creator

  validates :password, unless: proc { |user| user.password.blank? }, format:
    {
      with: /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*\W)/,
      message: ' should contain at least an alphabet, a digit and a special character'
    }

  validates :name, :user_type, presence: true

  scope :unavailable, ->(project_id) { joins(:project_users).where('project_users.project_id = ?', project_id) }
  scope :available, ->(project_id) { where.not(user_type: 1, id: unavailable(project_id)) }

  after_create :send_email

  private

  def send_email
    UserMailer.with(user: self).signed_up.deliver_later
  end
end
