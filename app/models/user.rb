class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { developer: 0, manager: 1, qa: 2 }

  has_many :bugs, dependent: :destroy
  has_many :developments, dependent: :destroy
  has_many :projects, through: :developments

  def set_default_role
    user_type
  end
end
