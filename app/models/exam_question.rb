class ExamQuestion < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  has_many :exam_answers, dependent: :destroy
  has_many :answers, through: :exam_answers
end
