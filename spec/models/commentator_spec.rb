require 'rails_helper'

RSpec.describe Commentator, type: :model do
  
  it 'should have proper attributes' do
    expect(subject.attributes).to include('name')
  end

  it 'should have many comments' do
    t = Commentator.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end

  it 'should require name to be present' do
    expect(Commentator.new).not_to be_valid
    expect(Commentator.new(name: 'Bob')).to be_valid
  end

end