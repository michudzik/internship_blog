class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @commentators = Commentator.all
    if params[:errors]
      @comment_errors = params[:errors]
    else
      @comment_errors = {}
    end
  end

  def new
    @post = Post.new
    @authors = Author.all.collect { |author| [ author.full_name, author.id ] }
  end

  def create
    @post = Post.new(post_params)
    @authors = Author.all.collect { |author| [ author.full_name, author.id ] }
    if @post.save
      redirect_to posts_url, notice: 'Post created'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @authors = Author.all.collect { |author| [ author.full_name, author.id ] }
  end

  def update
    @post = Post.find(params[:id])
    @authors = Author.all.collect { |author| [ author.full_name, author.id ] }
    if @post.update(post_params)
      redirect_to posts_url, notice: 'Post has been updated'
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to posts_url, notice: 'Post deleted'
    else
      redirect_to posts_url, alert: 'Could not delete post'
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :author_id)
    end

end