class ApplicationMailer < ActionMailer::Base
  add_template_helper OrderDetailsHelper
  default from: "noreply@example.com"
  layout "mailer"
end
