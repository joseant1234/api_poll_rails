FactoryGirl.define do
  factory :question do
    association :my_poll, factory: :my_poll
		description "¿Cuál es tu navegador preferido?"
  end
end
