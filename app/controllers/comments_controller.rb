class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    @comment.commentable_type == "User" ? redirect_to(user_url(@comment.commentable_id)) : redirect_to(goal_url(@comment.commentable_id))
  end

  def destroy
    @comment = Comment.find(params[:id])
    id = @comment.commentable_id
    type = @comment.commentable_type
    @comment.destroy
    type == "User" ? redirect_to(user_url(id)) : redirect_to(goal_url(id))
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
