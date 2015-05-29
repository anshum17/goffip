class CommentController < ApplicationController


  #####
  # :params => {:body, :post_id}
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
