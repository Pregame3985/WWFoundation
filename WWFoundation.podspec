Pod::Spec.new do |s|
  s.name         = "WWFoundation"
  s.version      = "0.0.1"
  s.summary      = "WWFoundation is a base foundation for building iOS app rapidly."
  s.license      = "MIT" 
  s.homepage     = "https://github.com/cocoismywife/WWFoundation"
  s.platform     = :ios
  s.author       = { "williamwu" => "william.wu.xudong@gmail.com" }
  s.source       = { :git => "https://github.com/cocoismywife/WWFoundation.git", :tag => "0.0.1" }
  s.source_files = "WWFoundation", "WWFoundation/**/*.{h,m}"
  s.requires_arc = true
end
