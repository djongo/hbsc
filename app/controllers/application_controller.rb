# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter { |c| Authorization.current_user = c.current_user }
  before_filter :mailer_set_url_options


  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user, :current_user_session


  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

#  private
  protected
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def permission_denied
      flash[:error] = "Sorry, you are not allowed to access that page."
      redirect_to root_url
    end
    
    def rescue_action_in_public(exception)
#      Notifier.error_notification(exception)
      flash[:error] = "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."     
      redirect_to root_url
    end
   
    
    
end
