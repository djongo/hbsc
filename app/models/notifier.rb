class Notifier < ActionMailer::Base

  default_url_options[:host] = "lrnbijxp.heroku.com" 

  def password_reset_instructions(user)
    subject     "Password Reset Instructions for HBSC"
    from        "Puma HBSC"
    recipients   user.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def workflow_notification(user,email)
    subject       email.subject
    from          "Puma HBSC"
    recipients    user.email
    content_type  "text/html"
    sent_on       Time.now
    body          :content => email.content
  end

end
