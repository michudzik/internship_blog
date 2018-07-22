class Post < ActiveRecord::Base
  validates :title,     presence:   true
  validates :title,     uniqueness: true
  validates :title,     length:     { maximum: 80 }
  validates :content,   presence:   true
  validates :content,   length:     { in: 10..500 }

  scope :old, -> { where('created_at < ?', 40.minutes.ago) }

  belongs_to :user

  has_many :comments, dependent: :destroy
end
