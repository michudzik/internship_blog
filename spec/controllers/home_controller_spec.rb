require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  
  describe '#home_page' do
    subject { get :home_page }

    describe 'successful response' do
      before { subject }
      it { expect(response).to redirect_to(new_user_session_url) }
    end
    
  end

end