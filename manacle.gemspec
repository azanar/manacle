require 'pathname'

Gem::Specification.new do |s|
  s.name        = "manacle"
  s.version     = "0.3.0"
  s.summary     = "A sticky constraint gem"

  s.description = <<-EOF
    Manacle will allow you to attach constraints to your objects that will persist across new instances of similar objects.

    As an example, you can constrain a Time object to always advance to the next hour. Then, if you add even one minute to that Time, it will snap to the next hour.
  EOF

  s.license     = "MIT"

  s.authors     = ["Ed Carrel"]
  s.email       = ["edward@carrel.org"]
  s.homepage    = "https://github.com/azanar/manacle"


  s.files       = Pathname.glob('lib/**/*.rb').map(&:to_path)
  #s.files       += Pathname.glob('test/**/*.rb').map(&:to_path)

  s.add_runtime_dependency 'punchout', '~> 0'

  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'mocha' 
  s.add_development_dependency 'simplecov'
end

