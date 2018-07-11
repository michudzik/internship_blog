class Author < ActiveRecord::Base
  #has_one :post
  validates :name,      presence:     true
  validates :surrname,  presence:     true
  validates :age,       numericality: { only_integer: true, greater_than: 0 }

  #has_many :author_posts
  #has_many :posts, through: :author_posts, dependent: :destroy
  has_many :posts
  before_create :annotate_author

  private 

    def annotate_author
      self.author = "#{slef.author} from Binar::Apps"
    end
end