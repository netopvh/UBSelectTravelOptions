#
# Be sure to run `pod lib lint UBSelectTravelOptions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UBSelectTravelOptions'
  s.version          = '0.2.7'
  s.summary          = 'A short description of UBSelectTravelOptions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://git.usemobile.com.br/libs-iOS/use-blue/select-travel-options'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Claudio Madureira Silva Filho' => 'claudio@usemobile.xyz' }
  s.source           = { :git => 'http://git.usemobile.com.br/libs-iOS/use-blue/select-travel-options.git', :tag => s.version.to_s }
  s.swift_version    = '4.2'
  s.ios.deployment_target = '10.0'
  s.source_files = 'UBSelectTravelOptions/Classes/**/*'
  s.resource_bundles = {
    'UBSelectTravelOptions' => ['UBSelectTravelOptions/Assets/*.png']
  }
  
end
