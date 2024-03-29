# frozen_string_literal: true

class Bug < ApplicationRecord
  BUG_TYPE_MAP = {
    Feature: :feature,
    Bug: :bug
  }.freeze

  FEATURE_STATUS_MAP = {
    New: :fresh,
    Started: :started,
    Completed: :completed
  }.freeze

  BUG_STATUS_MAP = {
    New: :fresh,
    Started: :started,
    Resolved: :resolved
  }.freeze

  enum bug_type: { feature: 0, bug: 1 }
  enum status: { fresh: 0, started: 1, completed: 2, resolved: 3 }

  has_one_attached :screenshot, dependent: :detach

  belongs_to :project
  belongs_to :creator, class_name: :User
  belongs_to :assignee, class_name: :User, inverse_of: :assigned_bugs

  validates :title, :deadline, :bug_type, :status, presence: true
  validates :title, uniqueness: { scope: :project_id }
  validates :screenshot, content_type: { in: %w[image/png image/gif], message: ' must be .png or .gif' }
  validate :future_time

  scope :assigned_to, ->(assignee_id) { where(assignee_id: assignee_id) }
  scope :created_by, ->(creator_id) { where(creator_id: creator_id) }

  before_validation :set_users, on: :create

  after_create :send_email

  private

  def set_users
    self.creator = Current.user
    self.assignee = User.new
  end

  def send_email
    BugMailer.with(bug: self).bug_reported.deliver_later
  end

  def future_time
    errors.add(:deadline, ' has already passed') if deadline && deadline < Date.current
  end
end
