class SubjectNotification
  def initialize subject
    @subject = subject
  end

  def send_notify_users
    @users = User.all
    @users.each do |user|
      UserMailer.notify_user_new_subject(user, @subject).deliver_now
    end
  end
end
