
require_relative '../SetUp'

Pod::Spec.new do |s|
  s.name             = 'MovieList'
  SetUp.new.setUp s

  s.source_files = 'MovieList/**/*'
  s.exclude_files = 'MovieList/Tests/**/*'
  s.resources = 'Networking/Module/**/*.{xcassets,json,storyboard,xib,xcdatamodeld}'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'MovieList/Tests/**/*.{swift}'
  end
  
  s.dependency 'Shared'
  s.dependency 'Utils'
  s.dependency 'Kingfisher'

end
