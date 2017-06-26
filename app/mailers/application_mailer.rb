class ApplicationMailer < ActionMailer::Base
  #include Resque::Mailer
  default from: "killer99sekar@gmail.com"
  layout 'mailer'
end
