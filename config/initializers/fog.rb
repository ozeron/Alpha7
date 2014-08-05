CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJK3UVLGBJ7DS26CQ',                        # required
    :aws_secret_access_key  => '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',                        # required
    :region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
  }
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end
  #config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
  #config.fog_public     = true     
  config.fog_directory   = Rails.env.production? ? 'alpha7' : 'alpha7dev'
end