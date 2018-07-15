require 'rails_helper'

RSpec.describe Commentator, type: :model do
  
  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('name')
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relations' do
    it { should have_many(:comments).dependent(:destroy) }
  end

end