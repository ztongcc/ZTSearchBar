#
# Be sure to run `pod lib lint ZTSearchBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZTSearchBar'
  s.version          = '0.1.0'
  s.summary          = 'A custom system search bar.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A custom system search bar.'

  s.homepage         = 'https://github.com/ztongcc'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jemis' => 'ztongcc@163.com' }
  s.source           = { :git => 'https://github.com/ztongcc/ZTSearchBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZTSearchBar/Classes/**/*'
  s.resource = 'ZTSearchBar/Assets/ZTSearchBar.bundle'

  # s.resource_bundles = {
  #   'ZTSearchBar' => ['ZTSearchBar/Assets/*.png']
  # }

   s.public_header_files = 'ZTSearchBar/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
