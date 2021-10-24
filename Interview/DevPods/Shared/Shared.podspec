require_relative '../SetUp'

Pod::Spec.new do |s|
  s.name             = 'Shared'
  SetUp.new.setUp s
  
  s.source_files = 'Shared/**/*'
  s.frameworks = 'UIKit'
end
