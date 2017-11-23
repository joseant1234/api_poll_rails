FactoryGirl.define do
  factory :user do
    email "uriel@codigofacilito.com"
		name "Uriel"
		provider "github"
		uid "duah18y2beda"
		factory :dummy_user do
			email "marcos@codigofacilito.com"
			name "Marcos"
			provider "facebook"
			uid "duah18y2beda"
		end
		factory :sequence_user do
			sequence(:email) { |n| "person#{n}@example.com" }
			name "Marcos"
			provider "facebook"
			uid "duah18y2beda"
		end
  end

end
