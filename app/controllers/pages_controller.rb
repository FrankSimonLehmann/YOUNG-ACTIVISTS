class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @demo = []
    @demonstrations = Demonstration.all
    @demonstrations.each do |demonstration|
      if demonstration.start_time > (Time.now)
        @demo << demonstration
      end
    end
    @demo = @demo.sort_by { |demo| demo.start_time}
  end

  def profile
    @user = User.find(current_user.id)
    @bookmark = Bookmark.where(user_id: current_user.id)

  end
end
