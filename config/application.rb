require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Alpha7
  class Application < Rails::Application
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
        YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false,
                       :fixture => true,
                       :fixture_replacement => "factory_girl"
      g.assets = false
      g.helper = false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end
