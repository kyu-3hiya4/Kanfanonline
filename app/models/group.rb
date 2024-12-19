class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy

  validates :name, presence: true
  validates :theme, presence: true

  def is_owned_by?(user)
    owner.id == user.id
  end

end
