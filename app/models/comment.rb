class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :content, length: { maximum: 160, minimum: 10 }
  belongs_to :post
  has_many :comment_commentators
  has_many :commentators, through: :comment_commentators
end