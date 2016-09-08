require "rails_helper"

RSpec.describe User, type: :model do

  context "user is valid" do
    user = FactoryGirl.create :user
    it {expect(user).to be_valid}
  end

  context "user is invalid" do
    user = FactoryGirl.build :user, :invalid_email
    it "invalid email" do
      expect(user).not_to be_valid
    end
  end

  context "avatar size validation" do
    it "valid avatar" do
      user = FactoryGirl.build :user, :small_avatar
      expect(user).to be_valid
    end

    it "large avatar" do
      user = FactoryGirl.build :user, :large_avatar
      expect(user).not_to be_valid
    end
  end

  context "class method" do
    it "send exam results successfully" do
      expect{User.send_exam_results}
        .to change {ActionMailer::Base.deliveries.count}.by(User.count)
    end
  end
end
