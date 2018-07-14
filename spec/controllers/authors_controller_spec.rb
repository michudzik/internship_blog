require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do 
  describe '#index' do
      subject{ get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end
    

    context 'authors' do
      let(:author_1) { create(:author) }
      let(:author_2) { create(:author) }

      it 'should return all authors' do
        subject
        expect(assigns(:authors)).to match_array([author_1, author_2])
      end
    end

  end

  describe '#show' do
    let(:author) { create(:author) }
    before{ get :show, params: { id: author.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('show') }
    end

    context 'author' do
      it { expect(assigns(:author)).to eq(author) }
    end

  end

  describe '#new' do
    before { get :new }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('new') }
    end

    context 'author' do
      it { expect(assigns(:author)).to be_a(Author) }
      it { expect(assigns(:author).persisted?).to eq(false) }
    end

  end

  describe '#edit' do
    let(:author) { create(:author) }
    before { get :edit, params: { id: author.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'author' do
      it { expect(assigns(:author)).to eq(author) }
    end

  end

  describe '#create' do
    let(:valid_parameters)    { { author: attributes_for(:author) } }
    let(:invalid_parameters)  { { author: attributes_for(:author, name: nil) } }

    context 'valid params' do
      subject { post :create, params: valid_parameters }

      it 'should redirect to authors index' do
        expect(subject).to redirect_to(authors_url)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should create new author' do
        expect{ subject }.to change{ Author.count }.by(1)
      end

    end

    context 'invalid params' do
      subject { post :create, params: invalid_parameters }

      it 'should render new' do
        expect(subject).to render_template('new')
      end

      it 'should not change author count' do
        expect{ subject }.not_to change{ Author.count }
      end

    end

  end

  describe '#update' do
    let(:author) { create(:author) }
    let(:valid_parameters) { { id: author.id, author: { name: 'valid'} } }
    let(:invalid_parameters) { { id: author.id, author: { name: nil} } }

    context 'valid params' do
      subject { patch :update, params: valid_parameters }

      it 'should redirect to authors index' do
        expect(subject).to redirect_to(authors_url)
      end

      it 'should redirect with a notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should change author\'s name' do
        subject
        expect(author.reload.name).to eq('valid')
      end

    end

    context 'invalid params' do
      subject { patch :update, params: invalid_parameters }

      it 'should render edit template' do
        expect(subject).to render_template('edit')
      end

      it 'should not change author\'s name' do
        subject
        expect(author.reload.name).not_to eq('valid')
      end

    end

  end

  describe '#destroy' do
    let(:author) { create(:author) }
    subject { delete :destroy, params: { id: author.id } }

    it 'should redirect to authors index' do
      expect(subject).to redirect_to(authors_url)
    end

    it 'should redirect with a notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'should change author count' do
      author_id = author.id
      expect{ delete :destroy, params: { id: author_id } }.to change{ Author.count }.by(-1)
    end

  end

end