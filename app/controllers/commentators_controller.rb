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
    commentator = Commentator.find(params[:id])
    if commentator.destroy
      redirect_to commentators_url, notice: 'Commentator deleted' 
    else
      redirect_to commentators_url, alert: 'Something went wrong'
    end
  end

  private

    def commentator_params
      params.require(:commentator).permit(:name)
    end

end