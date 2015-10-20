Pod::Spec.new do |s|
  s.name         = "Banana"
  s.version      = "0.0.2"
  s.summary      = "A customizable dropdown menu"
  s.homepage     = "https://github.com/Nonouf/Banana"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author             = { "Arnaud Schildknecht" => "arnaud.schild@gmail.com" }
  s.requires_arc = true
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/Nonouf/Banana.git", :tag => s.version.to_s }
  s.source_files  = "Banana", "Banana/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  # s.resource  = "icon.png"
  s.ios.frameworks = 'UIKit'  
end
