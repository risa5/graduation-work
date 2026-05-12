class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("GMAIL_ADDRESS")
  layout "mailer"
end
