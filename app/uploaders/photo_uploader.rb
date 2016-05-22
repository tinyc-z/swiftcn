class PhotoUploader < BaseUploader
  process resize_to_limit: [1280, nil]

  # Override the filename of the uploaded files:

  def filename
    if super.present?
      @name = Digest::MD5.hexdigest(File.dirname(current_path))
      "#{Time.now.strftime('%Y%m')}/#{model.user_id}_#{@name}.#{file.extension.downcase}"
    end
  end

  def store_dir
    "uploads/photos"
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  # def default_url
  #   "photo/#{version_name}.jpg"
  # end

end
