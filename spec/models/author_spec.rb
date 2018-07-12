require 'rails_helper'

RSpec.describe Author, type: :model do

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }

    it 'should require age to be an integer' do
      expect(Author.new(name: 'name', surname: 'surname', age: 1.5)).not_to be_valid
      expect(Author.new(name: 'name', surname: 'surname', age: 1)).to be_valid
    end

    it 'should require age to be a postivie integer' do
      expect(Author.new(name: 'name', surname: 'surname', age: -1)).not_to be_valid
    end

    it 'should allow age to be nil' do
      author = Author.new(name: 'name', surname: 'surname')
      author.age = nil

      expect(author).to be_valid
    end
  end

  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('name', 'surname', 'age')
    end
  end
  
  describe 'scopes' do
    it 'should have old scope' do
      young_author = Author.create(name: 'test', surname: 'test', age: 25)
      old_author = Author.create(name: 'test', surname: 'test', age: 55)

      expect(Author.old).to include(old_author)
      expect(Author.old).not_to include(young_author)
    end
  end
  
  describe 'callbacks' do
    it 'should set age to 25 if non was given' do
      author = Author.create(name: 'test', surname: 'test')
      expect(author.age).to eq(25)
    end
  end
  
  describe 'relations' do
    it { should have_many(:posts) }
  end
  
  describe '#fullname' do
    it 'should return author\'s fullname' do
     author = Author.new(name: 'name', surname: 'surname')
     expect(author.full_name).to eq('name surname')
    end
  end

end