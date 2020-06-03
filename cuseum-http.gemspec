require_relative 'lib/cuseum/http/version'

Gem::Specification.new do |spec|
  spec.name          = "cuseum-http"
  spec.version       = Cuseum::Http::VERSION
  spec.authors       = ["mbajur"]
  spec.email         = ["mbajur@gmail.com"]

  spec.summary       = %q{Custom Cuseum HTTP client library}
  spec.description   = %q{Custom Cuseum HTTP client library}
  spec.homepage      = "https://cuseum.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Cuseum/cuseum-http"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "sentry-raven"

  spec.add_runtime_dependency "sorbet-runtime"
end
