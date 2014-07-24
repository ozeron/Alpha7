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
     "/images/default/#{model.class.to_s.underscore}_default.png"
   end

  # Process files as they are uploaded:
   process :resize_to_fit => [150, 150]

  # Create different versions of your uploaded files:
  version :thumb do
     process :resize_to_fit => [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
   def extension_white_list
     %w(jpg jpeg gif png)
   end
end
