require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  
  describe '#welcome' do
    subject { get :welcome }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('welcome') }
    end
    
  end

end