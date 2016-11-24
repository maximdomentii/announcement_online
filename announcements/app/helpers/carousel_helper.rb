module CarouselHelper

  def carousel_for(images, imagesObj, annId)
    Carousel.new(self, images, imagesObj, annId).html
  end

  class Carousel
    include AnnouncementsHelper

    def initialize(view, images, imagesObj, annId)
      @view, @images, @imagesObj, @annId = view, images, imagesObj, annId
      @uid = SecureRandom.hex(6)
    end

    def html
      content = safe_join([indicators, slides, controls])
      content_tag(:div, content, id: uid, class: 'carousel slide')
    end

    private

    attr_accessor :view, :images, :uid, :imagesObj, :annId
    delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

    def indicators
      items = images.count.times.map { |index| indicator_tag(index) }
      #content_tag(:ol, safe_join(items), class: 'carousel-indicators')
      points = content_tag(:ol, safe_join(items), class: 'carousel-indicators')

      del_items = imagesObj.map { |img| deletion_tag(img) }
      dels = content_tag(:ol, safe_join(del_items), class: 'carousel-indicators')

      divs = [points, dels]

      content_tag(:div, safe_join(divs), class: 'carousel-indicators-groups')
    end

    def indicator_tag(index)
      options = {
          class: (index.zero? ? 'active' : ''),
          data: {
              target: uid,
              slide_to: index
          }
      }

      content_tag(:li, '', options)
    end

    def deletion_tag(index)
      content_tag(:li, link_to('Remove this image', announcement_image_path(index.id, annId), method: :delete, data: {confirm: 'Are you sure?' }), class: 'ann-image-remove')
    end

    def slides
      items = images.map.with_index { |image, index| slide_tag(image, index.zero?) }
      content_tag(:div, safe_join(items), class: 'carousel-inner')
    end

    def slide_tag(image, is_active)
      options = {
          class: (is_active ? 'item active' : 'item'),
      }

      content_tag(:div, image_tag(image), options)
    end

    def controls
      safe_join([control_tag('left'), control_tag('right')])
    end

    def control_tag(direction)
      options = {
          class: "#{direction} carousel-control",
          data: { slide: direction == 'left' ? 'prev' : 'next' }
      }

      icon = content_tag(:i, '', class: "glyphicon glyphicon-chevron-#{direction}")
      control = link_to(icon, "##{uid}", options)
    end
  end
end