class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.default_mail
  layout "mailer"
end
