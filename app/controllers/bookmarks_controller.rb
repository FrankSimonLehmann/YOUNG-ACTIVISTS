class BookmarksController < ApplicationController
  # def new
  #   # @user = Bookmark.find(params[:user_id])
  #   @bookmark = Bookmark.new
  # end
  def show
    @bookmarks = Bookmarks.all
  end

  def create
    @bookmark = Bookmark.where(user_id: current_user.id, demonstration_id: params[:demonstration_id]).first
    authorize @bookmark
    unless @bookmark
      @bookmark = Bookmark.new(demonstration_id: params[:demonstration_id])
      @bookmark.user = current_user
    end
    if @bookmark.save
      redirect_to demonstration_path(params[:demonstration_id])
    else
      redirect_to demonstration_path(params[:demonstration_id])
    end
  end

  def destroy
    
    @bookmark = Bookmark.where(user_id: current_user.id, demonstration_id: params[:demonstration_id]).first
    authorize @bookmark
    unless @bookmark
      @bookmark.destroy
      redirect_to bookmark_list
    end
  end
end
