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
end
