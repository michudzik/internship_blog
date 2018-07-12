class Author < ActiveRecord::Base
  #has_one :post
  validates :name,      presence:     true
  validates :surname,   presence:     true
  validates :age,       numericality: { only_integer: true, greater_than: 0, allow_nil: true }

  scope :old, -> { where('age > 30') }
  scope :young, -> { where('age < 20') }

  before_create :default_age

  #has_many :author_posts
  #has_many :posts, through: :author_posts, dependent: :destroy
  has_many :posts

  def full_name 
    "#{self.name} #{self.surname}"
  end

  private

    def default_age
      self.age = 25 unless age
    end

end