class DemonstrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
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
      format.text { render partial: "demonstrations/list_demonstrations", locals: { demonstrations: @demonstrations }, formats: [:html] }
    end
  end

  def show
    @demonstrations = Demonstration.all
    @demonstration = Demonstration.find(params[:id])
    authorize @demonstration # Add this line
    @markers =
      [{
        lat: @demonstration.latitude,
        lng: @demonstration.longitude,
        image_url: helpers.asset_url("logo1.jpg")
      }]
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
    if @demonstration.user.id == current_user.id
    authorize @demonstration
    end
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
    if @demonstration.user.id == current_user.id
      @demonstration.destroy
      authorize @demonstration
      redirect_to demonstrations_path
    end
  end


  private


  def demonstration_params
    params.require(:demonstration).permit(:title, :description, :location, :start_time, :end_time, :extra_info, {:topic_ids => []}, {:type_ids => []})
  end
end
