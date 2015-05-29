class PostsController < ApplicationController

  def index
    response = Post.get_all_posts params[:user_id]
    render :json => response, status: 200
  end

end
