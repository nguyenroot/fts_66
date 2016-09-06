class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions

  enum status: {start: 0, testing: 1, uncheck: 2, checked: 3}

  before_create :create_exam_questions

  after_create :set_default, :notify_user

  accepts_nested_attributes_for :exam_questions

  def update_status is_finished_or_checked = false
    if self.start?
      self.testing!
      self.update started_at: Time.now
      delete_delayed_job
    elsif self.testing?
      if (get_remain_time < 0 || is_finished_or_checked)
        self.uncheck!
        calculate_score
      end
      update_spent_time
    elsif self.uncheck? && is_finished_or_checked
      self.checked!
      ExamResultWorker.perform_async self
    end
  end

  def get_remain_time
     endtime = self.started_at + subject.duration.minutes
     seconds = endtime.to_i - Time.now.to_i
  end

  def score
    exam_questions.where(is_correct: true).count
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

  def calculate_score
    exam_questions.each do |exam_question|
      exam_question.check_correct
    end
  end

  def update_spent_time
    start_time = self.started_at
    seconds = self.updated_at.to_i - start_time.to_i
    seconds = subject.duration.minutes if seconds > subject.duration.minutes
    self.update spent_time: seconds
  end

  def notify_user
    exam_notify = ExamNotify.new self
    Delayed::Job.enqueue exam_notify, Settings.exams.notify_priority,
      Settings.exams.notify_hour.hours.from_now, queue: "exam-#{id}"
  end

  def delete_delayed_job
    Delayed::Job.find_by(queue: "exam-#{id}").delete
  end
end
