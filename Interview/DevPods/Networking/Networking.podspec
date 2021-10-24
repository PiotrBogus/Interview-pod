require_relative '../SetUp'

Pod::Spec.new do |s|
  s.name             = 'Networking'
  SetUp.new.setUp s
  
  s.source_files = 'Networking/**/*'
  s.exclude_files = 'Networking/Tests/**/*'

  s.frameworks = 'UIKit'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Networking/Tests/**/*.{swift}'
  end
  
  s.dependency 'Shared'
  s.dependency 'Utils'
end
