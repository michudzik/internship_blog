class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(params[:comment][:post_id]), notice: 'Comment added'
    else
      redirect_to post_url(params[:comment][:post_id]), alert: 'Something went wrong'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to post_url(comment.post_id), notice: 'Comment deleted'
    else
      redirect_to post_url(comment.post_id), alert: 'Could not delete the comment'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :content, :commentator_id)
    end
end