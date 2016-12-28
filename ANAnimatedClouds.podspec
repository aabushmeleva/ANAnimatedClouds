Pod::Spec.new do |s|

  s.name         = "ANAnimatedClouds"
  s.version      = "0.1.0"
  s.summary      = "Some categories for iOS developers"
  s.homepage     = "https://github.com/aabushmeleva/ANAnimatedClouds.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Anna Bushmeleva" => "aabushmeleva@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/aabushmeleva/ANAnimatedClouds.git" }
  s.source_files = "ANAnimatedClouds/**/*.{h,m}"
  s.public_header_files = "ANAnimatedClouds/**/*.{h}"
  s.framework    = "UIKit"
  s.requires_arc = true

end
