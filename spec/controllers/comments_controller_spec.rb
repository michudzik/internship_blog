require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  
  describe '#create' do
    let(:user)         { create(:user) }
    let(:post_object)                { create(:post) }
    let(:valid_parameters)    { { comment: attributes_for(:comment, user_id: user.id, post_id: post_object.id) } }
    let(:invalid_parameters)  { { comment: attributes_for(:comment, user_id: nil, post_id: post_object.id) } }
    before { sign_in user }
    context 'valid params' do
      subject { post :create, params: valid_parameters }

      it 'should redirect to proper post' do
        expect(subject).to redirect_to(post_url(post_object.id))
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should create new author' do
        expect{ subject }.to change{ Comment.count }.by(1)
      end

    end

    context 'invalid params' do
      subject { post :create, params: invalid_parameters }

      it 'should redirect to proper post' do
        expect(subject).to redirect_to %r(\A#{post_url(post_object.id)})
      end
      it 'should not change comment count' do
        expect{ subject }.not_to change{ Comment.count }
      end

    end
  end

  describe '#destroy' do
    let(:comment) { create(:comment) }
    subject { delete :destroy, params: { id: comment.id } }

    it 'should redirect to proper post' do
      expect(subject).to redirect_to(post_url(comment.post_id))
    end

    it 'should redirect with a notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'should change post count' do
      comment_id = comment.id
      expect{ delete :destroy, params: { id: comment_id } }.to change{ Comment.count }.by(-1)
    end

  end

end