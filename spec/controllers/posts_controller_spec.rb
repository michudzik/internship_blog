require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe '#index' do
    subject { get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    context 'posts' do
      let(:post_1) { create(:post) }
      let(:post_2) { create(:post) }

      it 'should return all posts' do
        subject
        expect(assigns(:posts)).to match_array([post_1, post_2])
      end
    end

  end

  describe '#show' do
    let(:post) { create(:post) }
    before{ get :show, params: { id: post.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('show') }
    end

    context 'post' do
      it { expect(assigns(:post)).to eq(post) }
    end

  end

  describe '#new' do
    before { get :new }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('new') }
    end

    context 'post' do
      it { expect(assigns(:post)).to be_a(Post) }
      it { expect(assigns(:post).persisted?).to eq(false) }
    end
  end

  describe '#edit' do
    let(:post) { create(:post) }
    before { get :edit, params: { id: post.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'post' do
      it { expect(assigns(:post)).to eq(post) }
    end

  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:valid_parameters)    { { post: attributes_for(:post, author_id: user.id) } }
    let(:invalid_parameters)  { { post: attributes_for(:post, title: nil) } }

    context 'valid params' do
      subject { post :create, params: valid_parameters }

      it 'should redirect to posts index' do
        expect(subject).to redirect_to(posts_url)
      end

      it 'should redirect with a notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should create a new post' do
        expect{ subject }.to change{ Post.count }.by(1)
      end

    end

    context 'invalid params' do
      subject { post :create, params: invalid_parameters }

      it 'should render new template' do
        expect(subject).to render_template('new')
      end

      it 'should not change post count' do
        expect{ subject }.not_to change{ Post.count }
      end
      
    end

  end

  describe '#update' do
    let(:post) { create(:post) }
    let(:valid_parameters) { { id: post.id, post: { title: 'valid' } } }
    let(:invalid_parameters) { { id: post.id, post: { title: nil } } }

    context 'valid params' do
      subject { patch :update, params: valid_parameters }

      it 'should redirect to post index' do
        expect(subject).to redirect_to(posts_url)
      end

      it 'should redirect with a notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should change post\'s title' do
        subject
        expect(post.reload.title).to eq('valid')
      end

    end

    context 'invalid params' do
      subject { patch :update, params: invalid_parameters }

      it 'should render edit template' do
        expect(subject).to render_template('edit')
      end

      it 'should not change post\'s title' do
        subject
        expect(post.reload.title).not_to eq('valid')
      end

    end

  end

  describe '#destroy' do
    let(:post) { create(:post) }
    subject { delete :destroy, params: { id: post.id } }

    it 'should redirect to post index' do
      expect(subject).to redirect_to(posts_url)
    end

    it 'should redirect with a notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'should change post count' do
      post_id = post.id
      expect{ delete :destroy, params: { id: post_id } }.to change{ Post.count }.by(-1)
    end

  end

end