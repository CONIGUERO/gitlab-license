lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitlab/license/version'

Gem::Specification.new do |spec|
  spec.name          = 'gitlab-license'
  spec.version       = Gitlab::License::VERSION
  spec.authors       = ['Douwe Maan', 'Stan Hu', 'Tyler Amos']
  spec.email         = ['douwe@gitlab.com', 'stanhu@gitlab.com', 'tamos@gitlab.com']

  spec.summary       = 'gitlab-license helps you generate, verify and enforce software licenses.'
  spec.homepage      = 'https://dev.gitlab.org/gitlab/gitlab-license'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3.0'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.80.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.38.1'
end
