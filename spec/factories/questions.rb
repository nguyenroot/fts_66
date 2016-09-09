FactoryGirl.define do
  factory :question do
    content {Faker::Lorem.sentence}
    answer_type "single_choice"
    status "not_confirm"

    factory :question_with_answer do
      transient do
        answers_count 4
      end
    end
    before(:create) do |question|
      question.answers.build([FactoryGirl.attributes_for(:answers)])
    end
  end
end
