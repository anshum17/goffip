class PostController < ApplicationController

  # def get_posts
  #   response = Post.get_all_posts
  #   render :json => response, status: 200
  # end


  #####
  # :params => {:body, :type}
  #####
  def create
    Post.create_post(params)
    render :json => {:message => 'Post Successfully Created'}, :status => 200
  end

  #####
  # :params => {:body, :id}
  #####
  def update
    result = Post.update_post(params)
    render :json => {:message => result[:message]}, :status => result[:status] ? 200 : 400
  end
end
