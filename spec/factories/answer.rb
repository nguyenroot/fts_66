FactoryGirl.define do
  factory :answer do
    question_id
    content {Faker::Lorem.sentence}
    is_correct true
  end
end
