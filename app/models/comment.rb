class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body, :like, :parent_id

  def self.create_comment(params)
    create(:body => params[:body], :post_id => params[:post_id], :user_id => @user.id)
  end

  def self.update_comment(params)
    comment = Comment.find(params[:id]) rescue nil
    return failure_messgage('Comment ID not found') if comment.nil?

    comment.update_attributes(:body => params[:body])
    return success_message('Comment Successfully updated.')
  end


  private

  def self.failure_message(message)
    {:message => message, :status => false}
  end

  def self.success_message(message)
    {:message => message, :status => true}
  end
end
