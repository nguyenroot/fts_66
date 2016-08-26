class ExamAnswer < ActiveRecord::Base
  belongs_to :exam_question
  belongs_to :answer
end
