class DemonstrationsController < ApplicationController
  def index
    @demonstrations = policy_scope(Demonstration)

    @demonstrations = Demonstration.all
    if params[:query].present?
      @demonstrations = Demonstration.search_by_title_and_description(params[:query])
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "demonstrations/list_demonstrations", locals: {demonstrations: @demonstrations}, formats: [:html] }
    end
  end

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
  def demonstration_params
  params.require(:demonstration).permit(:title, :description, :location, :start_time, :end_time, :extra_info)
  end
end
