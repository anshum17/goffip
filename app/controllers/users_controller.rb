class UserController < ApplicationController

  def index
    user = User.find(@user.id)
    result = user.get_profile()
    render :json => {:payload => result}, :status => 200
  end

  def create
    User.create_user(params)
  end

  def update
    user = User.find(@user.id)
    user.update_profile(params)
    render :json => {:message => 'Department Successfully Updated'}, :status => 200
  end
end
