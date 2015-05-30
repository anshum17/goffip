class UsersController < ApplicationController

  ## get profile of user
  def index
    user = User.find(@user.id)
    result = user.get_profile()
    render :json => {:payload => result}, :status => 200
  end

  ## create user
  def create
    result = User.create_user(params)
    render :json => {:payload => result[:user], :message => result[:message]}, :status => result[:status] ? 200 : 400
  end

  ##update user info
  def update
    user = User.find(@user.id) rescue nil
    if user.nil?
      render :json => {:message => 'User not found'}, :status => 400
      return
    end
    response = user.update_profile(params)
    render :json => {:message => response[:message]}, :status => response[:status] ? 200 : 400
  end

  def search
    result = User.app_search(params[:query])
    render :json => {:payload => result}, :status => 200
  end

end
