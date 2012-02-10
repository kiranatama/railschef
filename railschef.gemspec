Gem::Specification.new do |s|
  s.name = "railschef"
  s.version = "0.1.1"
  s.author = "Kiranatama"
  s.email = "info@kiranatama.com"
  s.homepage = "http://www.kiranatama.com"
  s.summary = "A collection of useful Rails generator scripts."
  s.description = "A collection of useful Rails generator scripts for layout files and authentication."

  s.files = Dir["{lib,test,features}/**/*", "[A-Z]*"]
  s.require_path = "lib"

  s.add_development_dependency 'rspec-rails', '~> 2.0.1'
  s.add_development_dependency 'cucumber', '~> 1.0.6'
  s.add_development_dependency 'rails', '~> 3.1.1'
  s.add_development_dependency 'mocha', '~> 0.9.8'
  s.add_development_dependency 'sqlite3-ruby', '~> 1.3.1'
  s.add_development_dependency 'omniauth', '~> 1.0.0'

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end

