Gem::Specification.new do |s|
  s.authors = ['Eli Foster']
  s.name = 'curseforge-butt'
  s.summary = 'Interacting with the CurseForge API'
  s.version = '0.1.0'
  s.license = 'CC-BY-NC-ND-4.0'
  s.description = 'CurseForge::Butt is a Ruby Gem that provides an interface ' \
                  'for accessing the CurseForge Web API using HTTPClient. ' \
                  'Its features are currently very limited until the API is ' \
                  'properly documented.'
  s.email = 'elifosterwy@gmail.com'
  s.homepage = 'https://github.com/elifoster/curseforge-butt'
  s.metadata = {
    'issue_tracker' => 'https://github.com/elifoster/curseforge-butt/issues'
  }
  s.post_install_message = 'ONE OF US! ONE OF US!'
  s.required_ruby_version = '>= 2.1'
  s.files = [
    'lib/curseforge_butt.rb',
    'CHANGELOG.md'
  ]

  s.add_runtime_dependency('httpclient', '~> 2.8')
  s.add_runtime_dependency('oj', '~> 2.18')
  s.add_runtime_dependency('mime-types', '~> 3.1')
end
