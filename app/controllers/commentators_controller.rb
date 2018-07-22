class CommentatorsController < ApplicationController
  def index
    @commentators = Commentator.all
  end

  def new
    @commentator = Commentator.new
  end

  def create
    @commentator = Commentator.new(commentator_params)
    if @commentator.save
      redirect_to commentators_url, notice: 'Commentator added'
    else
      render :new
    end
  end

  def destroy
    @commentator = Commentator.find(params[:id])
    respond_to do |format|
      if @commentator.destroy
        format.html { redirect_to commentators_url, notice: 'Commentator deleted' }
        format.js
      else
        format.html { redirect_to commentators_url, alert: 'Something went wrong' }
      end
    end
  end

  private

  def commentator_params
    params.require(:commentator).permit(:name)
  end
end
