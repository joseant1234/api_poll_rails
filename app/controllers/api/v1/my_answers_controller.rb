class Api::V1::MyAnswersController < Api::V1::MasterApiController
	before_action :authenticate

	def create
		# params { poll_id: 1, answer_id: 2 } 

		poll = MyPoll.find(params[:my_poll_id])
		answer = Answer.find(params[:answer_id])

		user_poll = UserPoll.custom_find_or_create(poll,@current_user)

		@my_answer = MyAnswer.custom_update_or_create(user_poll,answer)

		if @my_answer
			render template: "api/v1/my_answers/show"
		else
			error_array!(@my_answer.errors.full_messages, :unprocessable_entity)
		end

	end


end