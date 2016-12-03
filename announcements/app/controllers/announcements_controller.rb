class AnnouncementsController < ApplicationController
  def show
    @announcement = Announcement.find(params[:id])
    click @announcement
    @announcement.save

    @announcement
  end

  def new
    if logged_in?
      @announcement = Announcement.new
    else
      redirect_to login_path(:from_add_ann => true)
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def create
    @announcement = Announcement.new announcement_params

    if @announcement.save
      flash[:success] = 'Announcement successfully added!'
      redirect_to announcements_path(:id => @announcement.id)
    else
      render 'new'
    end
  end

  def update
    @announcement = Announcement.find params[:id]

    if @announcement.update announcement_params
      redirect_to announcements_path(:id => @announcement.id)
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @announcement = @category.announcements.find params[:id]
    @announcement.destroy

    redirect_to category_path(@category)
  end

  private

  def announcement_params
    ann_params = params.require(:announcement).permit(:title, :description, :category_id, :price_value, :price_currency)
    if ann_params[:price_value].empty?
      ann_params[:price_value] = nil
      ann_params[:price_currency] = nil
    end
    ann_params['user_id'] = current_user.id
    ann_params['valid_to'] = Date.today + 1.year
    ann_params
  end

  def click announcement
    if logged_in? && (current_user.role != User.roles[:admin])
      announcement.clicks = announcement.clicks + 1
    else
      announcement.clicks = announcement.clicks + 1
    end

  end
end
