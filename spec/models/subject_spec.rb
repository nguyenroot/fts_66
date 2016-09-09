require "rails_helper"

RSpec.describe Subject, type: :model do
  context "subject is valid" do
    subject = FactoryGirl.create :subject
    it {expect(subject).to be_valid}
  end

  context "picture size validation" do
    subject = FactoryGirl.build :subject
    it "large image" do
      subject = FactoryGirl.build :large_image
      expect(subject).not_to be_valid
    end

    it "valid image" do
      subject = FactoryGirl.build :small_image
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it {is_expected.to have_many :questions}
    it {is_expected.to have_many :exams}
    it {is_expected.to have_many :users}
  end

  describe "Validation" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :question_number}
    it {is_expected.to validate_presence_of :duration}
  end

end

