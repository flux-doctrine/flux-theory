Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = "flux-theory"
  gem.homepage           = "https://github.com/flux-doctrine/flux-theory"
  gem.license            = "Unlicense"
  gem.summary            = "Flux Theory for Ruby"
  gem.description        = "A modern evolution on flow-based programming (FBP)."
  gem.metadata           = {
    'bug_tracker_uri'   => "https://github.com/flux-doctrine/flux-theory/issues",
    'changelog_uri'     => "https://github.com/flux-doctrine/flux-theory/blob/master/ruby/CHANGES.md",
    'documentation_uri' => "https://rubydoc.info/gems/flux-theory",
    'homepage_uri'      => "https://flux-theory.dev",
    'source_code_uri'   => "https://github.com/flux-doctrine/flux-theory",
  }

  gem.author             = "Arto Bendiken"
  gem.email              = "arto@bendiken.net"

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CHANGES.md README.md UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w()

  gem.required_ruby_version = '>= 3.2'
  gem.add_development_dependency 'rspec', '~> 3.13'
  gem.add_development_dependency 'yard' , '~> 0.9'
end
