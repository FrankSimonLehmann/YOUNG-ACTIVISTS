class DemonstrationsController < ApplicationController
  def index
    @demonstrations = policy_scope(Demonstration)
    @topics = Topic.all
    @types = Type.all


    if params[:query].present? && params[:type].present? && params[:topic].present?
      types = params[:type].split(" ")
      topics = params[:topic].split(" ")
      @demonstrations = Demonstration.search_by_title_and_description([types, topics, params[:query]])
    elsif params[:query].present? && params[:topic].present?
      topics = params[:topic].split(" ")
      @demonstrations = Demonstration.search_by_title_and_description([params[:query], topics])
    elsif params[:query].present? && params[:type].present?
      types = params[:type].split(" ")
      @demonstrations = Demonstration.search_by_title_and_description([params[:query], types])
    elsif params[:type].present? && params[:topic].present?
      types = params[:type].split(" ")
      topics = params[:topic].split(" ")
      @demonstrations = Demonstration.search_by_title_and_description([types, topics])
    elsif params[:query].present?
      @demonstrations = Demonstration.search_by_title_and_description(params[:query])
    elsif params[:topic].present?
      topics = params[:topic].split(" ")
      @demonstrations = Demonstration.search_by_title_and_description(topics)
      puts @demonstrations
    elsif params[:type].present?
      types = params[:type].split(" ")
      @demonstrations = Demonstration.search_by_title_and_description(types)
      puts @demonstrations
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "demonstrations/list_demonstrations", locals: {demonstrations: @demonstrations}, formats: [:html] }
    end
    @markers = @demonstrations.geocoded.map do |demonstration|
      {
        lat: demonstration.latitude,
        lng: demonstration.longitude
      }
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

  def edit
    @demonstration = Demonstration.find(params[:id])
    authorize @demonstration
  end

  def update
    @demonstration = Demonstration.find(params[:id])
    @demonstration.update(demonstration_params)
    authorize @demonstration
    if @demonstration.save
      redirect_to demonstration_path(@demonstration)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @demonstration = Demonstration.find(params[:id])
    @demonstration.destroy
    authorize @demonstration
    redirect_to demonstrations_path
  end

  private


  def demonstration_params
    params.require(:demonstration).permit(:title, :description, :location, :start_time, :end_time, :extra_info, :topic, :type)
  end
end
