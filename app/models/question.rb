class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :exam_questions, dependent: :destroy
  has_many :exams, through: :exam_questions

  enum status: {not_confirm: 0, confirmed: 1, rejected: 2}
  enum type: {single_choice: 0, multi_choice: 1, text: 2}
end
