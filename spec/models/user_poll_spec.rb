require 'rails_helper'

RSpec.describe UserPoll, type: :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :my_poll }

  describe "self.custom_find_or_create" do
  	it "crea un nuevo registro con un nuevo poll y un nuevo usuario" do
  		user = FactoryGirl.create(:user)
  		my_poll = FactoryGirl.create(:my_poll)
  		expect{
  			UserPoll.custom_find_or_create(my_poll,user)
  		}	.to change(UserPoll,:count).by(1)
  	end

  	it "encuentra un registro con el mismo poll y usuario" do
  		user_poll = FactoryGirl.create(:user_poll)

  		expect{
  			UserPoll.custom_find_or_create(user_poll.my_poll,user_poll.user)
  		}	.to change(UserPoll,:count).by(0)
  	end
  end

end
