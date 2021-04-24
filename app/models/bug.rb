class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: :User
  belongs_to :assignee, class_name: :User, inverse_of: :assigned_bugs

  enum bug_type: { feature: 0, bug: 1 }
  enum status: { new_bug: 0, started: 1, completed: 2, resolved: 3 }

  has_one_attached :screenshot

  validates :title, :deadline, :bug_type, :status, presence: { message: ' is missing' }
  validates :title, uniqueness: { scope: :project_id }
  validates :screenshot, content_type: {in: %w[image/png image/gif], message: ' must be .png or .gif'}
end
