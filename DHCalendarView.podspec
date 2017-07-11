#
#  Be sure to run `pod spec lint DHCalendarView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "DHCalendarView"
s.version      = "1.0.4"
s.summary      = "日历"
s.description  = <<-DESC
好用的日历
DESC
s.homepage     = "https://github.com/DajuanM/DHCalendarView"
s.license      = "MIT"
s.author       = { "Aiden" => "252289287@qq.com" }
s.source       = { :git => "https://github.com/DajuanM/DHCalendarView.git", :tag => "#{s.version}" }
s.source_files  = "DHCalendarView","DHCalendarView/**/*.{h,m}"
s.requires_arc = true
s.ios.deployment_target = '8.0'
end
