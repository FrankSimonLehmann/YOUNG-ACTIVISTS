class BookmarksController < ApplicationController
  # def new
  #   # @user = Bookmark.find(params[:user_id])
  #   @bookmark = Bookmark.new
  # end
  def show
    @bookmarks = Bookmarks.all
  end

  def create
    @bookmark = Bookmark.new(demonstration_id: params[:demonstration_id])
    @bookmark.user = current_user
    authorize @bookmark
    if @bookmark.save
      redirect_to demonstration_path(params[:demonstration_id])
    else
      redirect_to demonstration_path(params[:demonstration_id])
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @demonstration = @bookmark.demonstration
    authorize @bookmark
    @bookmark.destroy
    redirect_to demonstration_path(@demonstration)
  end

  def joined
    @joinedbookmark = []
    @bookmark = Bookmark.all
    @bookmark.each do |bookmark|
      if bookmark.demonstration.id == params[:demonstration_id].to_i
        @joinedbookmark << bookmark
      end
    end
    authorize @bookmark
  end
end
