class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions

  enum status: {start: 0, testing: 1, uncheck: 2, failed: 3, passed: 4}
end
