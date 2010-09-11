class Notifier < ActionMailer::Base
  def password_reset_instructions(user)
    subject     "Password Reset Instructions for HBSC"
    from        "Puma HBSC"
    recipients  user.email
    sent_on     Time.now
    body        :edit_password_reset_url => edit_password_reset_url(user.persistence_token)
  end
end
