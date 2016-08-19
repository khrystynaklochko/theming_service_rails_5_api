require 'rails_helper'

RSpec.describe "Users request", type: :request do
  
  describe "GET /users" do
    it "works! (now write some real specs)" do
      FactoryGirl.create(:user)
      get '/users/1'
      expect(response).to be_success
    end
  end

end
