
require_relative '../SetUp'

Pod::Spec.new do |s|
  s.name             = 'UITestsCore'
  SetUp.new.setUp s
  
  s.source_files = 'UITestsCore/**/*'
  
  s.frameworks = 'XCTest'
  
  s.dependency 'Shared'
end
