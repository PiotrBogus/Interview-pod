require_relative '../SetUp'

Pod::Spec.new do |s|
  s.name             = 'PagesLinks'
  SetUp.new.setUp s
  
  s.source_files = 'PagesLinks/**/*'
  s.exclude_files = 'PagesLinks/Tests/**/*'

  s.frameworks = 'UIKit'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'PagesLinks/Tests/**/*.{swift}'
  end
end
