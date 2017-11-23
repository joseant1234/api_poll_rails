require 'rails_helper'

RSpec.describe MyAnswer, type: :model do
  it{ should validate_presence_of :user_poll }
 	it{ should validate_presence_of :answer } 

 	describe "self.custom_update_or_create" do
  	it "crea un nuevo registro con un nuevo user_poll y answer" do
  		user_poll = FactoryGirl.create(:user_poll)
  		answer = FactoryGirl.create(:answer)

  		expect{
  			MyAnswer.custom_update_or_create(user_poll,answer)
  		}.to change(MyAnswer,:count).by(1)

  	end

  	it "encuentra y actualiza con el mismo user_poll y answer" do
			my_answer = FactoryGirl.create(:my_answer)

			my_answer.update(question: my_answer.answer.question)

			expect{
  			MyAnswer.custom_update_or_create(my_answer.user_poll,my_answer.answer)
  		}.to change(MyAnswer,:count).by(0)
  	end
  end


end
