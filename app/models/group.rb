class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy

  has_many :users, through: :group_users, source: :user

  validates :name, presence: true
  validates :theme, presence: true

  def self.search(content, method)
    if method == 'perfect'
      Group.where(['name LIKE(?) OR theme LIKE(?)', "#{content}", "#{content}"])
    elsif method == 'forward'
      Group.where(['name LIKE(?) OR theme LIKE(?)', "#{content}%", "#{content}%"])
    elsif method == 'backward'
      Group.where(['name LIKE(?) OR theme LIKE(?)', "%#{content}", "%#{content}"])
    else
      Group.where(['name LIKE(?) OR theme LIKE(?)', "%#{content}%", "%#{content}%"])
    end
  end

  def is_owned_by?(user)
    owner_id == user.id
  end

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end

end
