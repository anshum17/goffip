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
    user = User.find(@user.id)
    user.update_profile(params)
    render :json => {:message => 'Department Successfully Updated'}, :status => 200
  end

  def search
    result = User.app_search(params[:query])
    render :json => {:payload => result}, :status => 200
  end

end
