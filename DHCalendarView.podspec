```
Pod::Spec.new do |s|
s.name = 'DHCalendarView's.version = '1.0'
s.license = 'MIT'
s.summary = '日历'
s.homepage = 'https://github.com/mcmore/hezi-sdk-for-ios'
s.authors = { 'DajuanM' => '252289287@qq.com' }
s.source = { :git => "https://github.com/DajuanM/DHCalendarView.git", :tag => "1.0"}
s.requires_arc = trues.ios.deployment_target = '7.0'
s.source_files = "DHCalendarView/*.{h,m}", "DHCalendarView/DHCalendarView.a"
s.source = "DHCalendarView/DHCalendarView.bundle"
s.frameworks = 'UIKit'
end
```