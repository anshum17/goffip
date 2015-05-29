class PostsController < ApplicationController

  def index
    response = Post.get_all_posts params[:user_id]
    render :json => response, status: 200
  end

  #####
  # :params => {:body, :type}
  #####
  def create
    profanity_check = Dictionary.check_profanity_words(params[:body])
    if profanity_check[:status]
      response = Post.create_post(params)
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

  def testing
    render :json => {:message => 'yay'}
  end

end
