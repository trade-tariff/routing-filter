# -*- encoding: utf-8 -*-
# stub: routing-filter 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "routing-filter".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alessandro De Simone, William Fish, Svend Fuchs".freeze]
  s.date = "2024-01-09"
  s.description = "Routing filters wraps around the complex beast that the Rails routing system is, allowing for unseen flexibility and power in Rails URL recognition and generation.".freeze
  s.email = "svenfuchs@artweb-design.de".freeze
  s.files = ["CHANGELOG.md".freeze, "MIT-LICENSE".freeze, "README.markdown".freeze, "lib/routing".freeze, "lib/routing-filter.rb".freeze, "lib/routing/filter.rb".freeze, "lib/routing_filter.rb".freeze, "lib/routing_filter/adapters".freeze, "lib/routing_filter/adapters/rails.rb".freeze, "lib/routing_filter/adapters/routers".freeze, "lib/routing_filter/adapters/routers/journey.rb".freeze, "lib/routing_filter/adapters/routers/rack_mount.rb".freeze, "lib/routing_filter/chain.rb".freeze, "lib/routing_filter/filter.rb".freeze, "lib/routing_filter/filters".freeze, "lib/routing_filter/filters/extension.rb".freeze, "lib/routing_filter/filters/locale.rb".freeze, "lib/routing_filter/filters/pagination.rb".freeze, "lib/routing_filter/filters/uuid.rb".freeze, "lib/routing_filter/result_wrapper.rb".freeze, "lib/routing_filter/version.rb".freeze]
  s.homepage = "http://github.com/svenfuchs/routing-filter".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Routing filters wraps around the complex beast that the Rails routing system is, allowing for unseen flexibility and power in Rails URL recognition and generation".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 7.1"])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 7.1"])
  s.add_development_dependency(%q<i18n>.freeze, [">= 0"])
  s.add_development_dependency(%q<minitest>.freeze, ["< 5.10.2"])
  s.add_development_dependency(%q<rack-test>.freeze, ["~> 0.6.2"])
  s.add_development_dependency(%q<rails>.freeze, [">= 7.1"])
  s.add_development_dependency(%q<test_declarative>.freeze, [">= 0"])
end
