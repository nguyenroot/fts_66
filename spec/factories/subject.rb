FactoryGirl.define do
  factory :subject do
    sequence(:name){Faker::Name.name}
    question_number 5
    duration 30

    factory :large_image do
      image_path File.open(Rails.root.join("spec/uploads/large_picture.jpg"))
    end

    factory :small_image do
      image_path File.open(Rails.root.join("spec/uploads/small_picture.jpg"))
    end
  end
end
