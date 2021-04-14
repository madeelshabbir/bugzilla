class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_one_attached :screenshot

  enum type: { feature: 0, bug: 1 }
  enum status: { _new: 0, started: 1, completed: 2, resolved: 3 }
end
