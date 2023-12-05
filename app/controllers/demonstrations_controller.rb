class DemonstrationsController < ApplicationController

  def show
    @demonstration = Demonstration.find(params[:id])
    authorize @demonstration # Add this line
  end

end
