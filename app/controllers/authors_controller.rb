class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    @author = Author.new
  end

  def show
    @author = Author.find(params[:id])
    @posts = @author.posts
  end

  def new 
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    respond_to do |format|
      if @author.save
        format.html { redirect_to authors_url, notice: 'Author has been created' }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  def edit 
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to authors_url, notice: 'Author has been updated'
    else
      render :edit
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    respond_to do |format|
      if @author.destroy
        format.html { redirect_to authors_url, notice: 'Author has been deleted' }
        format.js
      else
        format.html { redirect_to authors_url, alert: 'Could not delete the author' }
      end
    end
  end

  private

    def author_params
      params.require(:author).permit(:name, :surname, :age)
    end

end