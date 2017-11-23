require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
	let(:my_app){ FactoryGirl.create(:my_app, user: FactoryGirl.create(:sequence_user)) }
	describe "POST /users" do
		before :each do
			auth = { provider: "facebook", uid: "12dsab1y23g12", info: { email: "u@mail.com" } }
			post "/api/v1/users", { auth: auth, secret_key: my_app.secret_key }
		end

		it { expect(response).to have_http_status(200) } 

		it { change(User,:count).by(1) }
		
		it "responds with the user found or created" do
			json = JSON.parse(response.body)
			expect(json["data"]["email"]).to eq("u@mail.com")
		end

		it "responds with the token" do
			token = Token.last
			expect(token.my_app).to_not be_nil
		end
	end
end