Pod::Spec.new do |s|
  s.name         = "NSExtensions"
  s.version      = "0.0.3"
  s.summary      = "A collection of useful extensions for standard Cocoa classes."
  s.homepage     = "https://github.com/skywinder/NSExtensions"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors       = { "Anthony Shoumikhin" => "anthony@shoumikh.in",
                      "Petr Korolev" => "sky4winder+nsextensions@gmail.com"}
  s.source       = { :git => "https://github.com/skywinder/NSExtensions.git", :tag => "0.0.3" }
  s.platform     = :ios, '5.1'
  s.source_files = 'Xtensions/*.{h,m}'
  s.public_header_files = 'Xtensions/*.h'
  s.frameworks = 'Foundation', 'UIKit', 'CoreData', 'MapKit'
  s.requires_arc = true
end
