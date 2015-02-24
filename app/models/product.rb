class Product < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "100x100#", :large => "500x500>"  }, :default_url => "https://YOURBUCKET.amazons3.com/:style/missing.png", :processors => [:cropper]
  do_not_validate_attachment_file_type :photo
  # validates_attachment_content_type :photo, :content_type => /\A\/.*\Z/
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  # after_update :reprocess_avatar, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def reprocess_avatar
    photo.reprocess!
  end

  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end

end



