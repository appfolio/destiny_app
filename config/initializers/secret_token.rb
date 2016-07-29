# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# You can use `rake secret` to generate a secure secret key.
# SECRET_KEY environment variable is used in production, defined in devise.rb
unless Rails.env.production?
  DestinyApp::Application.config.secret_key_base = 'f9379fcbac50cade4b665d31de877be88ad1760adc78f24764439f1f5473ea1fe5490a317663940c6a2cbaffdcd198ad77d5784f66eac02250f454792959d6a9'
  DestinyApp::Application.config.pepper = "f5a53ecb8f04ed693adb818a9b94460a87d9097de1d8908bb62639e731184a2dc48e08a3213aab771be3fe8e3f89dd81e6f78ffde897a14e250fbaa5ac4ce3fa"
end
