# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file
   
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "images/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
   "/images/default/" + [version_name, "user_default.png"].compact.join('_')
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [150, 150]

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  version :small_thumb, :from_version => :thumb do
    process resize_to_fill: [20, 20]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end 


end
