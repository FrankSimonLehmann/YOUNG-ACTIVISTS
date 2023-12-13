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
      @realbookmark = @realbookmark.sort_by { |bookmark| bookmark.demonstration.start_time}
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
    @bookmark = @bookmark.sort_by { |bookmark| bookmark.demonstration.start_time }

    @realbookmark = []
    @bookmark.each do |bookmark|
      if bookmark.demonstration.start_time > (Time.now)
        @realbookmark << bookmark
      end
    end
    @realbookmark = @realbookmark.sort_by { |bookmark| bookmark.demonstration.start_time}

    @demonstrations = @user.demonstrations
    @demonstrations = @demonstrations.sort_by { |demonstration| demonstration.start_time}
    @realdemonstration = []
    @demonstrations.each do |demonstration|
      if demonstration.start_time > (Time.now)
        @realdemonstration << demonstration
      end
    end
    @realdemonstration = @realdemonstration .sort_by { |demonstration| demonstration.start_time}



  end

  def bookmarked
    @bookmark = Bookmark.where(user_id: current_user.id)
    @bookmark = @bookmark.sort_by { |bookmark| bookmark.demonstration.start_time}
  end

  def mydemonstrations
    @demonstration = Demonstration.where(user_id: current_user.id)
    @demonstration = @demonstration.sort_by(&:start_time)
  end
end
