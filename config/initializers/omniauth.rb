Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ruffnote, ENV['RUFFNOTE_CLIENT_ID'], ENV['RUFFNOTE_CLIENT_SECRET'], client_options: { site: ENV['RUFFNOTE_SITE'], }
end
OmniAuth.config.logger = Rails.logger

