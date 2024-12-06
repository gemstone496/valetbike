class ApplicationMailer < ActionMailer::Base
  default from: "#{Rails.application.credentials.dig(:smtp, :user_name)}@gmail.com"
  layout "mailer"
end
