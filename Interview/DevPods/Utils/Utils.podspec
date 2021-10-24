
require_relative '../SetUp'

Pod::Spec.new do |s|
  s.name             = 'Utils'
  SetUp.new.setUp s
  SetUp.new.excludeArm64 s
  
  s.source_files = 'Utils/**/*'
  s.frameworks = 'UIKit'
  
  s.dependency 'Shared'
  s.dependency 'PagesLinks'
  
#  s.test_spec 'Tests' do |test_spec|
#    test_spec.source_files = 'Utils/Tests/**/*.{swift}'
#  end
end
