class ExamResultWorker
  include Sidekiq::Worker

  def perform exam
    UserMailer.send_exam_result(exam).deliver_now
  end
end
