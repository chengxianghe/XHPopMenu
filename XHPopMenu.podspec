#
#  Be sure to run `pod spec lint XHPopMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name            = "XHPopMenu"
  s.version         = "1.1.0"
  s.summary         = "A menu like a pop view."
  s.description     = <<-DESC
			It is a menu view used on iOS, which implement by Objective-C.
                   DESC
  s.homepage        = "https://github.com/chengxianghe/XHPopMenu"
  s.screenshots     = "https://github.com/chengxianghe/watch-gif/raw/master/PopMenu.gif?raw=true"
  s.license         = "MIT"
  s.author          = { "chengxianghe" => "chengxianghe@outlook.com" }
  s.platform        = :ios, "8.0"
  s.source          = { :git => "https://github.com/chengxianghe/XHPopMenu.git", :tag => s.version }
  s.source_files    = "XHPopMenu/*"
  s.frameworks      = 'Foundation', 'UIKit'
  s.requires_arc    = true

end
