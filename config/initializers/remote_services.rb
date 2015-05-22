yaml_configuration = ERB.new(IO.read(File.join(Rails.root.to_s, 'config/remote_services.yml'))).result
services_configuration = YAML.load(yaml_configuration)[Rails.env]

AfRuntime::Core::RemoteServices.instance(Rails.application.name, services_configuration)
