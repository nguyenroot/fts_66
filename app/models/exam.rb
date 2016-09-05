class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions

  enum status: {start: 0, testing: 1, uncheck: 2, checked: 3}

  before_create :create_exam_questions

  after_create :set_default

  accepts_nested_attributes_for :exam_questions

  def update_status is_finished = false
    if self.start?
      self.testing!
      self.update started_at: Time.now
    elsif self.testing? && (get_remain_time < 0 || is_finished)
      self.uncheck!
    end
  end

  def get_remain_time
     endtime = self.started_at + subject.duration.minutes
     seconds = endtime.to_i - Time.now.to_i
  end

  private
  def create_exam_questions
    confirmed_questions = subject.questions.confirmed.order("RANDOM()")
      .limit subject.question_number
    confirmed_questions.each do |question|
      self.exam_questions.build question_id: question.id,
        is_correct: Settings.exams.default_correct
    end
  end

  def set_default
    self.start!
    self.update score: Settings.exams.default_score,
      spent_time: Settings.exams.default_spent_time
  end
end
