require 'rails_helper'

RSpec.describe Api::V1::MyPollsController, type: :request do

	let(:my_app){ FactoryGirl.create(:my_app, user: FactoryGirl.create(:sequence_user)) }

	describe "GET /polls" do

		before :each do
			FactoryGirl.create_list(:my_poll, 10)
			get "/api/v1/polls", { secret_key: my_app.secret_key }
		end

		it { expect(response).to have_http_status(200) }
		it "mande la lista de encuestas" do
			json = JSON.parse(response.body)
			expect(json["data"].length).to eq(MyPoll.count)
		end
	end

	describe "GET /polls/:id" do
		before :each do
			@poll = FactoryGirl.create(:my_poll)
			get "/api/v1/polls/#{@poll.id}", { secret_key: my_app.secret_key }
		end

		it { expect(response).to have_http_status(200) }

		it "manda la encuesta solicitada" do
			json = JSON.parse(response.body)
			expect(json["data"]["id"]).to eq(@poll.id)
		end

		it "manda los atributos de la encuesta" do
			json = JSON.parse(response.body)
			expect(json["data"]["attributes"].keys).to contain_exactly("id","title","description","expires_at","user_id","created_at","updated_at")
		end

	end

	describe "POST /polls" do
		context "con token válido" do
			before :each do
				@token = FactoryGirl.create(:token,expires_at: DateTime.now + 10.minutes)
				post "/api/v1/polls", { token: @token.token,secret_key:my_app.secret_key, poll: { title: "Hola mundo", description: "asdasd asd asd asd asd", expires_at: DateTime.now } }
			end
			it { expect(response).to have_http_status(200) }
			it "crea una nueva encuesta" do
				expect{
					post "/api/v1/polls", { token: @token.token,secret_key: my_app.secret_key, poll: { title: "Hola mundo", description: "asdasd asd asd asd asd", expires_at: DateTime.now }  }	
				}.to change(MyPoll,:count).by(1)
			end
			it "responde con la encuesta creada" do
				json = JSON.parse(response.body)
				expect(json["data"]["attributes"]["title"]).to eq("Hola mundo")
			end

		end
		context "con token inválido" do
			before :each do
				post "/api/v1/polls", { secret_key: my_app.secret_key }
			end

			it {expect(response).to have_http_status(401) }

		end
		context "unvalid params" do
			before :each do
				@token = FactoryGirl.create(:token,expires_at: DateTime.now + 10.minutes)
				post "/api/v1/polls", { token: @token.token, poll: { title: "Hola mundo",
															 expires_at: DateTime.now }, secret_key: my_app.secret_key }
			end

			it { expect(response).to have_http_status(422) }

			it "responde con los errores al guardar la encuesta" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end

		end
	end

	describe "PATCH /polls/:id" do
		context "con un token válido" do
			before :each do
				@token = FactoryGirl.create(:token,expires_at: DateTime.now + 10.minutes)
				@poll = FactoryGirl.create(:my_poll,user: @token.user)
				patch api_v1_poll_path(@poll), { token: @token.token,secret_key:my_app.secret_key, poll: { title: "Nuevo título" } }
			end
			it { expect(response).to have_http_status(200) }

			it "actualiza la encuesta indicada" do
				json = JSON.parse(response.body)
				expect(json["data"]["attributes"]["title"]).to eq("Nuevo título")
			end

		end
		context "con un token inválido" do
			before :each do
				@token = FactoryGirl.create(:token,expires_at: DateTime.now + 10.minutes)
				@poll = FactoryGirl.create(:my_poll,user: FactoryGirl.create(:dummy_user))
				patch api_v1_poll_path(@poll), { token: @token.token,secret_key:my_app.secret_key, poll: { title: "Nuevo título" } }
			end
			it { expect(response).to have_http_status(401) }
		end
	end
	describe "DELETE /polls/:id" do
		context "con un token válido" do
			before :each do
				@token = FactoryGirl.create(:token,expires_at: DateTime.now + 10.minutes)
				@poll = FactoryGirl.create(:my_poll,user: @token.user)
			end
			it { 
				delete api_v1_poll_path(@poll), { token: @token.token, secret_key:my_app.secret_key}
				expect(response).to have_http_status(200) 
			}

			it "elimina la encuesta indicada" do
				expect{
					delete api_v1_poll_path(@poll), { token: @token.token, secret_key: my_app.secret_key}
				}.to change(MyPoll,:count).by(-1)
			end

		end
		context "con un token inválido" do
			before :each do
				@token = FactoryGirl.create(:token,expires_at: DateTime.now + 10.minutes)
				@poll = FactoryGirl.create(:my_poll,user: FactoryGirl.create(:dummy_user))
				delete api_v1_poll_path(@poll), { token: @token.token, secret_key: my_app.secret_key}
			end
			it { expect(response).to have_http_status(401) }
		end
	end

end