class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(params[:comment][:post_id]), notice: 'Comment added' }
        format.js
      else
        format.html { redirect_to post_url(params[:comment][:post_id], errors: @comment.errors.full_messages), alert: 'Something went wrong' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post_id = @comment.post_id
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to post_url(post_id), notice: 'Comment deleted' }
        format.js
      else
        format.html { redirect_to post_url(post_id), alert: 'Could not delete the comment' }
      end
    end 
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :content, :commentator_id)
    end
    
end