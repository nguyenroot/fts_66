require "rails_helper"

RSpec.describe Question, type: :model do
  question = FactoryGirl.create :question
  describe "Associations" do
    it {is_expected.to have_many :answers}
    it {is_expected.to have_many :exam_questions}
    it {is_expected.to have_many :exams}
  end

  describe "Validation" do
    it {is_expected.to validate_presence_of :content}
    it {is_expected.to validate_presence_of :answer_type}
    it {is_expected.to validate_presence_of :status}
  end

end
