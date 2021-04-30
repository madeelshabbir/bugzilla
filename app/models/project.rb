class Project < ApplicationRecord
  before_create :set_user

  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :bugs, dependent: :destroy

  belongs_to :creator, class_name: :User, inverse_of: :created_projects

  validates :title, uniqueness: { case_sensitive: false }

  private

  def set_user
    users << Current.user
  end
end
