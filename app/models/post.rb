class Post < ActiveRecord::Base
  validates :title,     presence:   true
  validates :title,     uniqueness: true
  validates :title,     length:     { maximum: 80 }
  validates :content,   presence:   true
  validates :content,   length:     { in: 10..500 }
  validates :author_id, presence:   true

  # Wyszukiwanie ze specyficznymi parametrami
  scope :old, -> { where('created_at < ?', 40.minutes.ago) }

  belongs_to :author #=> One one or one many
  # has_many :author_posts
  # has_many :authors, through: :author_posts
  has_many :comments, dependent: :destroy
end
