class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :content, length: { maximum: 160, minimum: 8 }

  belongs_to :post
  belongs_to :user
end
