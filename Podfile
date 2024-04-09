# platform :ios, '13.0'

target 'Otmetka-x' do
  use_frameworks!
  inhibit_all_warnings!

  # Code Style
  pod 'SwiftFormat/CLI', '~> 0.49.18'
  pod 'SwiftLint'
  pod 'R.swift', '~> 6.1.0'

  # Network
  pod 'Kingfisher', '~> 7.6.2'
  pod 'Moya', '~> 13.0.1'
  pod 'Gloss'

  # UI
  pod 'SnapKit', '~> 5.0.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
  installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
              if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
              end
             end
        end
 end
end
