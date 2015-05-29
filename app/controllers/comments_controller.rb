class CommentsController < ApplicationController

  def like_comment
    response = Comment.process_like(params)
    if response['status'] == false
      render :json => response, status: 400
    else
      render :json => response, status: 200
    end
  end

  #####
  # :params => {:body, :post_id}
  #####
  def create
    profanity_check = Dictionary.check_profanity_words(params[:body])
    if profanity_check[:status]
      response = Post.create_post(params, @user)
      render :json => {:message => response[:message]}, :status => response[:status] ? 200 : 400
    else
      render :json => {:message => profanity_check[:message]}, status => 400
    end
  end

  #####
  # :params => {:body, :id}
  #####
  def update
    profanity_check = Dictionary.check_profanity_words(params[:body])
    if profanity_check[:status]
      result = Post.update_post(params)
      render :json => {:message => result[:message]}, :status => result[:status] ? 200 : 400
    else
      render :json => {:message => profanity_check[:message]}, status => 400
    end
  end

  def delete
    Comment.delete_comment(params)
    render :nothing => true, :status => 200
  end

end
