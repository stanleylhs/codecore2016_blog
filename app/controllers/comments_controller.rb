# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  commenter  :string
#  body       :text
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        AnswersMailer.notify_post_owner(@comment).deliver_later
        format.html { redirect_to post_path(@post), notice: "Comment created" }
        format.js { render :comment_success }
      else
        format.html { render "posts/show" }
        format.js { render :comment_failure }  
      end
    end 
  end

  def destroy
    # @comment = @post.comments.find(params[:id])
    # binding.remote_pry
    @comment = Comment.find(params[:id])
    unless can? :manage, @comment 
      redirect_to root_path, alert: "access denied!"
    end
    @comment.destroy
    respond_to do |wants|
      wants.html { redirect_to post_path(@post) }
      wants.js { render }
    end
    
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
