class RatingsController < ApplicationController
  def create
    @announcement = Announcement.find(params[:announcement_id])
    @rating = @announcement.ratings.create(rating_params)
    redirect_to announcements_path(:id => @announcement.id)
  end

  def destroy
    @announcement = Announcement.find(params[:announcement_id])
    @rating = @announcement.ratings.find params[:id]
    @rating.destroy

    redirect_to announcements_path(:id => @announcement.id)
  end

  private
  def rating_params
    params.require(:rating).permit(:rank, :comment)
  end
end
