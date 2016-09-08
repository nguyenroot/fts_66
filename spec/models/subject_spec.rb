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
end
