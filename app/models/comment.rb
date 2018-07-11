class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :content, length: { maximum: 160, minimum: 10 }
  belongs_to :post
  belongs_to :commenter
end