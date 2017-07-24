require 'rails_helper'

RSpec.describe 'API Users', type: :request do
  describe 'GET /users' do
    let!(:users) { create_list(:user, 10) }
    let(:dummy_token) { double(:acceptable? => true) }

    before do
      allow_any_instance_of(Api::V1::BaseController).to receive(:doorkeeper_token).and_return(dummy_token)
    end

    it 'sends a list of users' do
      get '/users', headers: { 'Accept' => 'application/vnd.oak.v1' }

      # Test for 200 status code
      expect(response).to have_http_status(:success)

      # Test that correct amount of data is returned
      json = JSON.parse(response.body)
      expect(json["data"].length).to eq(10)
    end
  end
end