class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(params[:comment][:post_id]), notice: 'Comment added'
    else
      redirect_to post_url(params[:comment][:post_id], errors: @comment.errors.full_messages), alert: 'Something went wrong'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post_id = comment.post_id
    if comment.destroy
      redirect_to post_url(post_id), notice: 'Comment deleted'
    else
      redirect_to post_url(post_id), alert: 'Could not delete the comment'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :content, :commentator_id)
    end
    
end