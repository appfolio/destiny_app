# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# You can use `rake secret` to generate a secure secret key.
if Rails.env.production?
  DestinyApp::Application.config.secret_key_base = ENV["SECRET_KEY_BASE"]
else
  DestinyApp::Application.config.secret_key_base = 'f9379fcbac50cade4b665d31de877be88ad1760adc78f24764439f1f5473ea1fe5490a317663940c6a2cbaffdcd198ad77d5784f66eac02250f454792959d6a9'
end
