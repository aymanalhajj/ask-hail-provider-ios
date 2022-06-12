# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
 end
end

target 'AskHailBusiness' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AskHailBusiness

pod 'MBProgressHUD'
pod 'Alamofire', '~> 4.2'
pod 'Kingfisher', '~> 4.0'
pod 'LXStatusAlert'
pod 'UIView+Shake'
pod 'AJMessage'
pod 'BottomPopup'
pod 'FSPagerView'
pod 'RxSwift'
pod 'RxCocoa'
pod 'FAPanels'
pod 'Cosmos', '~> 16.0'
pod "BSImagePicker", "~> 3.1"
pod 'JHSpinner'
pod 'OTPFieldView'
pod 'TextFieldEffects'
pod 'IQKeyboardManager'
pod "PageControls/PillPageControl"
pod 'Firebase/Core'
pod 'FirebaseMessaging'
pod 'NotificationBannerSwift'
pod 'GoogleMaps' , '~> 3.9.0'
pod 'GooglePlaces'
pod 'STTabbar'
pod 'Socket.IO-Client-Swift', '~> 15.2.0'
pod 'Firebase/DynamicLinks'

pod 'Toast-Swift', '~> 5.0.1'
pod 'lottie-ios'
pod 'PMAlertController'
pod 'Firebase/Crashlytics'
pod 'Firebase/Analytics'


end
