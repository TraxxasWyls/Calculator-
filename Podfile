# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!
target 'Calculator!' do
  pod "SwiftyDAO"
end
post_install do |installer|
  # This removes the warning about swift conversion, hopefuly forever!
  installer.pods_project.root_object.attributes['LastSwiftMigration'] = 9999
  installer.pods_project.root_object.attributes['LastSwiftUpdateCheck'] = 9999
  installer.pods_project.root_object.attributes['LastUpgradeCheck'] = 9999
  installer.pods_project.targets.each do |t|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      end
    end
    installer.pods_project.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
