class CommentsController < ApplicationController


  #####
  # :params => {:body, :post_id}
  #####
  def create
    profanity_check = Dictionary.check_profanity_words(params[:body])
    if profanity_check[:status]
      Post.create_post(params)
      render :json => {:message => 'Post Successfully Created'}, :status => 200
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

end
