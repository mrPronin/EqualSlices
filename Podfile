# Uncomment the next line to define a global platform for your project
platform :ios, '14.5'

# CocoaPods master specs
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def pods
  # Pods for Project
  pod 'ChainLayout'
  pod 'Then'
end

target 'EqualSlices' do

  pods
  
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.5'
     end
   end
 end
