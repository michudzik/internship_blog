class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :content, length: { maximum: 160, minimum: 8 }
  validates :post_id, presence: true
  validates :commentator_id, presence: true
  
  belongs_to :post
  belongs_to :commentator
end
