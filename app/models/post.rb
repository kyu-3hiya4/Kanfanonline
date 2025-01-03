class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validate :at_least_one_field_present, if: -> { draft? && (title.blank? || body.blank?) }

  validates :title, presence: true, if: -> { status == "published" }
  validates :body, presence: true, if: -> { status == "published" }

  enum status: { draft:0, published: 1, unpublished: 2 }

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def at_least_one_field_present
    if title.blank? && body.blank?
      errors.add(:base, "タイトルか本文のどちらかは必須です")
    end
  end

  def draft?
    status == "draft" # 下書き状態の場合はtrueを返す
  end

end

