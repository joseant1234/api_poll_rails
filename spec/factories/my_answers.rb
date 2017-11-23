FactoryGirl.define do
  factory :my_answer do
    association :user_poll, factory: :user_poll
    association :answer, factory: :answer
  end

end
