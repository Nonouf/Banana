Pod::Spec.new do |s|
  s.name         = "Banana"
  s.version      = "0.0.1"
  s.summary      = "A customizable dropdown menu"
  s.description  = <<-DESC
                   A longer description of Banana in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

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
