class PostsController < ApplicationController

  def index
    response = Post.get_all_posts(params,@user)
    render :json => {:payload => response}, status: 200
  end

  #####
  # :params => {:body, :type}
  #####
  def create
    profanity_check = Dictionary.check_profanity_words(params[:body])
    if profanity_check[:status]
      response = Post.create_post(params, @user)
      render :json => {:message => response[:message]}, :status => response[:status] ? 200 : 400
    else
      render :json => {:message => profanity_check[:message]}, :status => 400
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
    Post.delete_post(params)
    render :json => {:message => 'Post successfully deleted'}, :status => 200
  end

  def get_post
    response = Post.get_post(params[:id], @user)
    if response['status'] == false
      render :json => {:payload => response}, status: 400
    else
      render :json => {:payload => response}, status: 200
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
