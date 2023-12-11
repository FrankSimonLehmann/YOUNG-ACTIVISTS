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
    @realbookmark = []
    @bookmark.each do |bookmark|
      if bookmark.demonstration.start_time > (Time.now)
        @realbookmark << bookmark
      end
    end

      @demo.each do |demo|
        if current_user.topics.include?(demo.topics.first) || current_user.types.include?(demo.types.first)
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
