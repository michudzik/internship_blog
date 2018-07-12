require 'rails_helper'

RSpec.describe Author, type: :model do

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }
    it { should validate_numericality_of(:age).only_integer }
    it { should validate_numericality_of(:age).allow_nil }
    it { should validate_numericality_of(:age).is_greater_than(0) }
  end

  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('name', 'surname', 'age')
    end
  end
  
  describe 'scopes' do
    let(:young_author)  { create(:author, age: 15) }
    let(:old_author)    { create(:author, age: 55) }

    it 'should have old scope' do
      expect(Author.old).to include(old_author)
      expect(Author.old).not_to include(young_author)
    end

    it 'should have young scope' do
      expect(Author.young).not_to include(old_author)
      expect(Author.young).to include(young_author)
    end
  end
  
  describe 'callbacks' do
    let(:author) { create(:author, age: nil) }

    it 'should set age to 25 if non was given' do
      expect(author.age).to eq(25)
    end
  end
  
  describe 'relations' do
    it { should have_many(:posts) }
  end
  
  describe '#fullname' do

    # create(:author) - zapisze obiekt w bazie danych
    # build(:author) - nie zapisze w bazie danych

    let(:author) { build(:author) }

    it 'should return author\'s fullname' do
     expect(author.full_name).to eq("#{author.name} #{author.surname}")
    end
  end

end