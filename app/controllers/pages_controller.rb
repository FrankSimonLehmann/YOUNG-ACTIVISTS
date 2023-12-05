class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @demonstrations = Demonstration.all
  end

  def user
    @user = User.find(current_user.id)
  end
end
