Rails.application.config.middleware.use OmniAuth::Builder do
  # Add a new provider when you need to authenticate using external provider.
  # See https://github.com/intridea/omniauth/wiki/List-of-Strategies for more details.
  # Please change KEY, SECRET, SCOPES, and DISPLAY appropriately.
  # For example,

  provider :developer unless Rails.env.production?
  # provider :facebook, KEY, SECRET, :scope => SCOPES, :display => DISPLAY
  # provider :twitter, KEY, SECRET
  # provider :google_oauth2, KEY, SECRET
  # provider :linkedin, KEY, SECRET
  # provider :github, KEY, SECRET
  # provider :foursquare, KEY, SECRET
end

