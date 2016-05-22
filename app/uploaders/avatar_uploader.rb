# encoding: utf-8
class AvatarUploader < BaseUploader

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :resize_to_fill => [320, 320]
  process :resize_and_pad => [320, 320, "#FFFFFF"]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_and_pad => [76, 76, "#FFFFFF"]
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def url
    if model.avatar_identifier.present? && model.avatar_identifier.start_with?('http')
      model.avatar_identifier
    else
      super
    end
  end

  def default_url
    "default_avatar.jpg"
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if super.present?
      "#{model.id}_#{Digest::MD5.hexdigest(model.name||"")[0,8]}.#{file.extension.downcase}"
    end
  end

  def store_dir
    "uploads/avatars"
  end


end
