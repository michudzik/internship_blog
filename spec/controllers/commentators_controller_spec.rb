require 'rails_helper' 

RSpec.describe CommentatorsController, type: :controller do
  
  describe '#index' do
    subject { get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    context 'commentators' do
      let(:commentator_1) { create(:commentator) }
      let(:commentator_2) { create(:commentator) }

      it 'should return all commentators' do
        subject
        expect(assigns(:commentators)).to match_array([commentator_1, commentator_2])
      end
    end

  end

  describe '#new' do
    before { get :new }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('new') }
    end

    context 'commentator' do
      it { expect(assigns(:commentator)).to be_a(Commentator) }
      it { expect(assigns(:commentator).persisted?).to eq(false) }
    end

  end

  describe '#create' do
    let(:valid_parameters)    { { commentator: attributes_for(:commentator) } }
    let(:invalid_parameters)  { { commentator: attributes_for(:commentator, name: nil) } }

    context 'valid params' do
      subject { post :create, params: valid_parameters}

      it 'should redirect to commentators index' do
        expect(subject).to redirect_to(commentators_url)
      end

      it 'should redirect with a notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should change commentator count' do
        expect{ subject }.to change{ Commentator.count }.by(1)
      end

    end

    context 'invalid params' do
      subject { post :create, params: invalid_parameters }

      it 'should render new template' do
        expect(subject).to render_template('new')
      end

      it 'should not change commentator count' do
        expect{ subject }.not_to change{ Commentator.count }
      end
    end

  end
  describe 'destroy' do
    let(:commentator) { create(:commentator) }
    subject { delete :destroy, params: { id: commentator.id } }

    it 'should redirect to commentator\'s index' do
      expect(subject).to redirect_to(commentators_url)
    end

    it 'should redirect with a notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'should change commentator\'s count' do
      commentator_id = commentator.id
      expect{ delete :destroy, params: { id: commentator_id } }.to change{ Commentator.count }.by(-1)
    end
  end
  
end