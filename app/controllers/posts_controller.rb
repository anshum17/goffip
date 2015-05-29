class PostsController < ApplicationController

  def index
    response = Post.get_all_posts(params)
    render :json => response, status: 200
  end

  def get_post
    response = Post.get_all_posts(params)
    if response['status'] == false
      render :json => response, status: 400
    else
      render :json => response, status: 200
    end
  end

  def like_post
    response = Post.process_like(params)
    if response['status'] == false
      render :json => response, status: 400
    else
      render :json => response, status: 200
    end
  end

end
