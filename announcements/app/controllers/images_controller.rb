class ImagesController < ApplicationController
  def create
    uploaded_io = image_params[:image_source]
    File.open(uploaded_io.path) do |sourcefile|
      File.open(Rails.root.join('public', 'uploads', 'image' + (Image.count+1).to_s + '.jpg'), 'wb') do |destinationfile|
        sourcefile.each_line do |line|
          destinationfile.write(line)
        end
      end
    end

    @announcement = Announcement.find(params[:announcement_id])
    @image = @announcement.images.create({:source_string => '/uploads/image' + (Image.count+1).to_s + '.jpg'})

    redirect_to announcements_path(:id => @announcement.id)
  end

  def destroy
    @announcement = Announcement.find(params[:announcement_id])
    @image = @announcement.images.find params[:id]
    @image.destroy

    redirect_to announcements_path(:id => @announcement.id)
  end

  private
  def image_params
    params.require(:image).permit(:image_source)
  end
end
