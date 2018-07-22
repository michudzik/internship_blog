require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('first_name', 'last_name')
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'methods' do
    describe '#full_name' do
      let(:user) { create(:user) }
      it 'should return proper full name' do
        expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
      end
    end
  end
end
