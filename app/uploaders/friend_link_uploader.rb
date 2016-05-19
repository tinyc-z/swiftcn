class FriendLinkUploader < BaseUploader
  
  process :resize_to_fill => [300, 100]
  process :resize_and_pad => [300, 100, "#FFFFFF"]

  # Override the filename of the uploaded files:

  def filename
    if super.present?
      model_id = model.id ||= "#{model.class.last.id+1}"
      "#{model_id}.#{file.extension.downcase}"
    end
  end

  def url
    if model.cover_identifier.present? && model.cover_identifier.start_with?('http')
      model.cover_identifier
    else
      super
    end
  end

  def store_dir
    "uploads/friend_links"
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  # def default_url
  #   "photo/#{version_name}.jpg"
  # end

end