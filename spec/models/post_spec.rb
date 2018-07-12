require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('title', 'content', 'author_id')
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:author_id) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_length_of(:title).is_at_most(80) }
    it { should validate_length_of(:content).is_at_least(10).is_at_most(500) }
  end
  
  describe 'scopes' do
    let(:author)      { Author.create(name: 'name', surname: 'surname') }
    let(:early_post)  { Post.create(title: 'title', content: 'testcontent', author_id: author.id) }
    let(:old_post)    { Post.create(title: 'title1', content: 'testcontent', author_id: author.id) }

    it 'should have old scope' do 
      old_post.update(created_at: 41.minutes.ago)

      expect(Post.old).not_to include(early_post)
      expect(Post.old).to include(old_post)
    end
  end
  
  describe 'relations' do
    it { should belong_to(:author) }
    it { should have_many(:comments) }
  end

end