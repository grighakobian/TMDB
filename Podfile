source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Domain' do
  
  # Pods for Domain
  pod 'RxSwift'
  
  target 'DomainTests' do
    # Pods for testing
  end
  
end

target 'Network' do
  
  # Pods for Network
  pod 'RxSwift'
  pod 'Moya/RxSwift'
  
  target 'NetworkTests' do
    # Pods for testing
  end

end

target 'TMDB' do
  
  # Pods for TMDB
  pod 'RxSwift'
  pod 'RxFlow'
  pod 'SDWebImage'
  pod 'Swinject'
  
  target 'TMDBTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TMDBUITests' do
    # Pods for testing
  end

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
     end
 end
end
