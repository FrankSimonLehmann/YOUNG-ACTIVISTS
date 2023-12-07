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
      format.text { render partial: "demonstrations/list_demonstrations", locals: { demonstrations: @demonstrations }, formats: [:html] }
    end
  end

  def show
    @demonstrations = Demonstration.all
    @demonstration = Demonstration.find(params[:id])
    authorize @demonstration # Add this line
    @markers = @demonstrations.geocoded.map do |demonstration|
      {
        lat: demonstration.latitude,
        lng: demonstration.longitude
      }
    end
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
      type_ids = params[:demonstration][:types].reject { |id| id == "" }
      type_ids.each { |id| DemoType.create(demonstration: @demonstration, type_id: id) }
      topic_ids = params[:demonstration][:topics].reject { |id| id == "" }
      topic_ids.each { |id| DemoTopic.create(demonstration: @demonstration, topic_id: id) }

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
      type_ids = params[:demonstration][:types].reject { |id| id == "" }
      existing_demo_types = @demonstration.demo_types
      existing_demo_types.each { |demo_type| demo_type.destroy unless type_ids.include?(demo_type.id.to_s) }
      type_ids -= existing_demo_types.map { |demo_type| demo_type.id.to_s }
      type_ids.each do |id|
        DemoType.create(demonstration: @demonstration, type_id: id)
      end

      topic_ids = params[:demonstration][:topics].reject { |id| id == "" }
      existing_demo_topics = @demonstration.demo_topics
      existing_demo_topics.each { |demo_topic| demo_topic.destroy unless topic_ids.include?(demo_topic.id.to_s) }
      topic_ids -= existing_demo_topics.map { |demo_topic| demo_topic.id.to_s }
      topic_ids.each do |id|
        DemoTopic.create(demonstration: @demonstration, topic_id: id)
      end

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
    params.require(:demonstration).permit(:title, :description, :location, :start_time, :end_time, :extra_info, :topics, :types)
  end
end
