class DemonstrationsController < ApplicationController

  def show
    @demonstration = Demonstration.find(params[:id])
    authorize @demonstration # Add this line
  end

  def new
    @demonstration = Demonstration.new
    authorize @demonstration
  end

  def create
    @demonstration = Demonstration.new(demonstration_params)
    @demonstration.user = current_user
    authorize @demonstration
    if @demonstration.save
      redirect_to demonstration_path(@demonstration)
    else
      render :new, status: :unprocessable_entity
    end
  end

#   def edit
#     @demonstration = Demonstration.find(params[:id])
#     authorize @demonstratio
#   end

#   def update
#     @demonstration = Demonstration.find(params[:id])
#     @demonstration.update(demonstration_params)
#     redirect_to saved_path(@demonstration)
#     authorize @demonstratio
#   end

#   def destroy

#   end
end