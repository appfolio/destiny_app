require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  if RbConfig::CONFIG["host_os"] == "linux-gnu"
    pjs = "linux-x86_64"
  else
    pjs = "macosx"
  end

  Capybara::Poltergeist::Driver.new(app, {
    phantomjs: Dir[Rails.root+"lib/phantomjs-1.9.7-#{pjs}/bin/phantomjs"]
  })
end
