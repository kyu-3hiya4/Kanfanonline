class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy

  validates :name, presence: true
  validates :theme, presence: true
end
