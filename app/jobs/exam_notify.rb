ExamNotify = Struct.new(:exam) do
  def perform
    UserMailer.notify_user_start_exam(exam).deliver_now
  end

  def destroy_failed_jobs?
    false
  end
end
