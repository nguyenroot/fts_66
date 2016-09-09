FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    sequence(:email){Faker::Internet.email}
    password "foobar"
    password_confirmation "foobar"

    trait :invalid_email do
      email "hoang"
    end

    trait :large_avatar do
      avatar_path File.open(Rails.root.join("spec/uploads/large_picture.jpg"))
    end

    trait :small_avatar do
      avatar_path File.open(Rails.root.join("spec/uploads/small_picture.jpg"))
    end

    trait :admin do
      role 1
    end
  end
end
