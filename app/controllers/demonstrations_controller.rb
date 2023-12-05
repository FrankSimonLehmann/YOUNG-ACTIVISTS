class DemonstrationsController < ApplicationController
  def index
    @topics = Topic.all
    @types = Type.all
    @demonstrations = policy_scope(Demonstration)
    @demonstrations = Demonstration.all

    if @types.name.inlcude?(params[:query])
      raise
      @demonstrations = Demonstration.pg_search_scope(params[:query])
    elsif params[:query].present?
      @demonstrations = Demonstration.search_by_title_and_description(params[:query])
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "demonstrations/list_demonstrations", locals: {demonstrations: @demonstrations}, formats: [:html] }
    end
    # if a button is clicked
      #@demontrations = Demonstration.where(topic: params[:topic])
  end

  def show
    @demonstration = Demonstration.find(params[:id])
    authorize @demonstration # Add this line
  end
end
