//
//  AppDelegate.swift
//  Astroshub
//
//  Created by Bhunesh Kahar on 07/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseInstanceID
import FirebaseAuth
import FirebaseMessaging
import FirebaseCore
import Fabric
import Crashlytics
import SJSwiftSideMenuController
import GoogleMaps
import GooglePlaces
import CoreLocation
//import Braintree
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(3)
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyAnbvBjqcrIfKaniwF0eWY0RPCH7mp_M3s")
        GMSPlacesClient.provideAPIKey("AIzaSyAnbvBjqcrIfKaniwF0eWY0RPCH7mp_M3s")
        FirebaseApp.configure()
        //BTAppSwitch.setReturnURLScheme("com.kriscent.testinguser.newuser-app.payments")
        //Stripe.setDefaultPublishableKey("pk_test_51HJFJ1KWWShMkLmumiGX9V9hWrg8kk611ZJ3NkElwiRI7Kq1LTc3ShJbfAeLMO89Dd4s2q8cvONLcYPtCAY8d0lj00FZzrIQvu")
        Stripe.setDefaultPublishableKey("pk_live_51HJFJ1KWWShMkLmub8SKi28vGy8euQlq9DJLfUW3k241VNOQ0avH3rBaW0zXSdllVJpYYGJU9OWK6rVSoWwpSUDi008HJUo2pi")
        self.moveToDashBoardVC()
        
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        return true
    }
    
    
    func moveToDashBoardVC() {
        
        let months = DateFormatter().monthSymbols
        let days = DateFormatter().weekdaySymbols
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = SJSwiftSideMenuController()
        
        let sideVC_L : SideMenuController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_L.menuItems = months as NSArray? ?? NSArray()
        
        let sideVC_R : SideMenuController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_R.menuItems = days as NSArray? ?? NSArray()
        
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController
        
        SJSwiftSideMenuController.setUpNavigation(rootController: initialViewControlleripad, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)
        
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 340
        
        let navigationController = UINavigationController(rootViewController: mainVC)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        if url.scheme?.localizedCaseInsensitiveCompare("com.kriscent.testinguser.newuser-app.payments") == .orderedSame {
//            return BTAppSwitch.handleOpen(url, options: options)
//        }
        return false
    }
    
    func registerAPNSServicesForApplication(_ application: UIApplication,withBlock block: @escaping (_ granted:Bool) -> (Void)) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {granted, error in
                
                if granted == true{
                    
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                    
                    // For iOS 10 display notification (sent via APNS)
                    UNUserNotificationCenter.current().delegate = self
                    
                }
                
                block(granted)
        })
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        Messaging.messaging().delegate = (self as MessagingDelegate)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        application.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        
        
        
        // Print full message.
        print(userInfo)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        
        // UIApplication.shared.applicationIconBadgeNumber = 0
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(UIBackgroundFetchResult.noData)
            return
        }
        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
        // Print full message.
        print(userInfo)
        
        
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print(deviceToken)
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                
                UserDefaults.standard.set(result.token, forKey: "FcmToken")
            }
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        let fcmToken1 = fcmToken
        print(fcmToken1)
        
        UserDefaults.standard.set(fcmToken1, forKey: "FcmToken")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
}

//[START ios_10_message_handling]
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        if UIApplication.shared.applicationState == .active { // In iOS 10 if app is in foreground do nothing.
            completionHandler([.alert, .badge, .sound])
        } else { // If app is not active you can show banner, sound and badge.
            completionHandler([.alert, .badge, .sound])
        }
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        completionHandler()
    }
}

class FileDownloader {
    
    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
            AutoBcmLoadingView.dismiss()
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
                AutoBcmLoadingView.dismiss()
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }
    
    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
}
