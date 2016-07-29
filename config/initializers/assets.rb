%w(devise users home cross_site_scripting mass_assignment sql_injection references challenges castle).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
end
