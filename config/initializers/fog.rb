CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['S3_KEY'],                # required
    :aws_secret_access_key  => ENV['S3_SECRET'],             # required
    :region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
  config.fog_public     = true
  config.fog_directory  = case Rails.env
                          when "production"
                            'alpha7'
                          when "development"
                            'alpha7dev'
                          else
                            'alpha7test'
                          end
end
