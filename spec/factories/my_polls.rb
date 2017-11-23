FactoryGirl.define do
  factory :my_poll do
    association :user, factory: :sequence_user
		expires_at "2015-05-23 12:54:39"
		title "MyStringaa"
		description "MyTextasdasd asd asd asd as"
		factory :poll_with_questions do
			title "Poll with questions"
			description "MyTextasdasd asda asd asd asd as"
			questions { build_list :question, 2 }
		end
  end

end
