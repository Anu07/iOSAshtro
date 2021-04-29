# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Astroshub' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'IQKeyboardManagerSwift'
  pod 'CRNotifications'
  #AnimationForCollectionView
  pod 'Gemini'
  
  #Side menu
  pod 'FAPanels'
  pod 'ObjectMapper', :git => 'https://github.com/tristanhimmelman/ObjectMapper.git', :branch => 'master'

  # FLoating text fields 
  pod 'SkyFloatingLabelTextField'
  pod 'Alamofire'
  pod 'ADCountryPicker'
  pod 'Kingfisher'
  pod 'SVProgressHUD'
  pod 'SDWebImage'
  pod 'SwiftyJSON'
  pod 'PGEZTransition'
  pod 'SJSwiftSideMenuController'
  pod 'FAPanels'
  pod 'NohanaImagePicker'
  pod 'Firebase/Analytics'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'FirebaseMessaging'
  pod 'Firebase/Storage'
  pod 'Firebase/Performance'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'MessageKit'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'iOSDropDown'
  pod 'Kingfisher'
  pod 'GoogleMaps'
  pod 'razorpay-pod', '~> 1.1.1'
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'BraintreeDropIn'
  pod 'Stripe'
  pod 'Cosmos', '~> 20.0'
  pod 'WOWRibbonView'
  pod 'FBSDKCoreKit'
   pod 'FBSDKLoginKit'
   pod 'FBSDKShareKit'
  
	post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'MessageKit'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '5.0'
              end
          end
      end
  end
  # Pods for Astroshub

end
