require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  if RbConfig::CONFIG["host_os"] == "linux-gnu"
    pjs = "linux-x86_64"
  else
    pjs = "macosx"
  end

  #pjs_logger = Rails.env.production? ? nil : STDOUT
  pjs_debug_logger = File.open("#{Rails.root}/log/debug_phantomjs.log", "a")
  pjs_logger = File.open("#{Rails.root}/log/phantomjs.log", "a")

  Capybara::Poltergeist::Driver.new(app, {
    phantomjs: Dir[Rails.root+"lib/phantomjs-1.9.7-#{pjs}/bin/phantomjs"],
    logger: pjs_debug_logger,
    phantomjs_logger: pjs_logger
  })
end
