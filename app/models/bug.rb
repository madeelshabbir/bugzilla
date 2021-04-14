class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum type: [:feature, :bug]
  enum status: [:new, :started, :completed, :resolved]
end
