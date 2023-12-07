class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @demo = []
    @weightdemo = []
    @demonstrations = Demonstration.all
    @demonstrations.each do |demonstration|
      if demonstration.start_time > (Time.now)
        @demo << demonstration
      end
    end
    @demo = @demo.sort_by { |demo| demo.start_time}
    if current_user != nil
    @bookmark = Bookmark.where(user_id: current_user.id)
      @demo.each do |demo|
        if demo.topics.first&.name == current_user.topic
          @weightdemo << demo
        end
      end
    end
    @weightdemo = @weightdemo.reverse
    @weightdemo.each do |weight|
      @demo.insert(0, weight)
    end
    @demo = @demo.uniq
    if current_user != nil
      @mydemonstrations = Demonstration.where(user_id: current_user.id)
    end
  end

  def profile
    @user = User.find(current_user.id)
    @bookmark = Bookmark.where(user_id: current_user.id)
  end

  def bookmarked
    @bookmark = Bookmark.where(user_id: current_user.id)
  end

  def mydemonstrations
    @demonstration = Demonstration.where(user_id: current_user.id)
  end
end
