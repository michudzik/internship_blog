require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('post_id', 'content', 'commentator_id')
    end
  end
  
  describe 'relations' do
    it { should belong_to(:commentator) }
    it { should belong_to(:post)}
  end
  
  describe 'validatons' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:commentator_id) }
    it { should validate_presence_of(:post_id) }
    it { should validate_length_of(:content).is_at_least(8).is_at_most(160) }
  end

end
  