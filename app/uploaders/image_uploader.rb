# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::Meta

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #Rails.logger.debug "(DEBUG) model.class.to_s.underscore: #{model.class.to_s.underscore}"
    #Rails.logger.debug "(DEBUG) mounted_as: #{mounted_as}"
    #Rails.logger.debug "(DEBUG) model.id: #{model.id}"
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :resize_to_limit => [940, 940]
  #
  # def scale(width, height)
  #   # do something
  # end
  process :store_meta

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_limit => [200, 200]
    #process :scale => [100, 100]
    process :store_meta
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end