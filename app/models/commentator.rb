class Commentator < ActiveRecord::Base
  validates :name, presence: true
  has_many :comment_commentators
  has_many :comments, through: :comment_commentators
end