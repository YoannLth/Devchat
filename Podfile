source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

workspace 'Devchat.xcworkspace'

def all_pods
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Kingfisher'
  pod 'Player', '~> 0.8.0'
end

target 'Devchat' do
    all_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
