class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum type: { feature: 0, bug: 1 }
  enum status: { new: 0, started: 1, completed: 2, resolved: 3 }
end
