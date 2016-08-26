class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :exam_answers
  has_many :exam_questions, through: :exam_answers
end
