require 'pathname'

Gem::Specification.new do |s|
  s.name        = "manacle"
  s.version     = "0.1.0"
  s.summary     = "A constraint persistency gem"

  s.description = <<-EOF
    Manacle is a "constraint persistency"
  EOF

  s.license     = "MIT"

  s.authors     = ["Ed Carrel"]
  s.email       = ["ed@pocketchange.com"]
  

  s.files       = Pathname.glob('lib/**/*.rb').map(&:to_path)
  s.files       += Pathname.glob('test/**/*.rb').map(&:to_path)

  s.add_runtime_dependency 'punchout'

  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'mocha' 
  s.add_development_dependency 'simplecov'
end

