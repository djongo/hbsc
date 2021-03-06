class Notifier < ActionMailer::Base

#  default_url_options[:host] = request.host_with_port #"lrnbijxp.heroku.com" 

  def password_reset_instructions(user)
    subject     "Password Reset Instructions for HBSC"
    from        "Puma HBSC"
    recipients   user.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
#  handle_asynchronously :password_reset_instructions

  def workflow_notification(user,email,publication)
    subject       email.subject
    from          "Puma HBSC"
    recipients    user.email
    content_type  "text/plain"
    sent_on       Time.now
    body          :content => email.content.gsub("[title]",publication.title).gsub("[id]",publication.id.to_s).gsub("[pi]",publication.responsible.full_name).gsub("[contact]",publication.contact_name).gsub("[created]",publication.created_at.strftime('%Y-%m-%d')).gsub("[updated]",publication.updated_at.strftime('%Y-%m-%d')).gsub("[first_name]",user.first_name).gsub("[last_name]",user.last_name).gsub("[full_name]",user.full_name).gsub("[email]",user.email)
  end
#  handle_asynchronously :workflow_notification
  
  def error_notification(exception)
    subject       "Puma HBSC Error"
    from          "Puma HBSC"
    recipients    "puma.hbsc@gmail.com"
    content_type  "text/plain"
    sent_on       Time.now
    body          exception
  end
end
