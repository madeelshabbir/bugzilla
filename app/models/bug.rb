class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :creator, class_name: 'User'

  enum _type: { feature: 0, bug: 1 }
  enum status: { _new: 0, started: 1, completed: 2, resolved: 3 }

  has_one_attached :screenshot

  validates :title, :deadline, :_type, :status, presence: { message: ' is missing' }
  validates :title, uniqueness: { scope: :project_id }

  validate :check_png_or_gif

  private

  def check_png_or_gif
    return unless screenshot.attached? && !screenshot.content_type.in?(%w[image/png image/gif])

    screenshot.purge
    errors.add(:screenshot, 'Screenshout must be .png or .gif')
  end
end
