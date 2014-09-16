Pod::Spec.new do |s|
  s.name         = "NSXtensions"
  s.version      = "0.69"
  s.summary      = "A collection of useful extensions for standard Cocoa classes."
  s.homepage     = "https://github.com/shoumikhin/NSXtensions"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Anthony Shoumikhin" => "anthony@shoumikh.in" }
  s.source       = { :git => "https://github.com/shoumikhin/NSXtensions.git", :tag => "0.69" }
  s.platform     = :ios, '5.1'
  s.source_files = 'Xtensions/*.{h,m}'
  s.public_header_files = 'Xtensions/*.h'
  s.frameworks = 'Foundation', 'UIKit', 'CoreData', 'MapKit'
  s.requires_arc = true
end
