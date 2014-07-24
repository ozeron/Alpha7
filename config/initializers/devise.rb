Devise.setup do |config|
  config.secret_key = 'd2468473ab45741e5bbbe19f4d41894fd8017909ace5b1829b93a28cb18d92a76e143f3298bfddf9be3c3dc6c92387090a0114695fb785f413423255952d4152'
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
