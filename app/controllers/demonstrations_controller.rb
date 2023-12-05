class DemonstrationsController < ApplicationController
  def index
    @demonstrations = policy_scope(Demonstration)
    
  end

  def show
    @demonstration = Demonstration.find(params[:id])
    authorize @demonstration # Add this line
  end
end
