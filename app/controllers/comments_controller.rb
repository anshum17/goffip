class CommentsController < ApplicationController

  def like_post
    response = Comment.process_like(params)
    if response['status'] == false
      render :json => response, status: 400
    else
      render :json => response, status: 200
    end
  end

end
