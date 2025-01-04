class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum status: { pending: 0, approval: 1, cancel: 2 }
end
