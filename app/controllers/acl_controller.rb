class AclController < ActionController::Base

  before_filter :authorize

  def find_current_user
    session_token = params[:session_token] || session[:session_token]
    @user = User.find_by_session_token(session_token) if !session_token.nil?
  end

  def authorize
    find_current_user
  end

end
