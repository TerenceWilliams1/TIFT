//
//  AppDelegate.swift
//  TIFT
//
//  Created by Terence Williams on 1/4/22.
//

import UIKit
import CoreData
import OneSignal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(3)
        TIFTHelper.updateLaunchCount(count: TIFTHelper.launchCount() + 1)
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("df2227b6-c36e-472f-8377-3508c00ca803")
        
//        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
//            // This block gets called when the user reacts to a notification received
//            if let additionalData = result!.notification.payload!.additionalData {
//                print("additionalData: ", additionalData)
//                print(additionalData["postId"] as! String)
//
//                if let postId = additionalData["postId"] as? String {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    if  let postDetailVC = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController,
//                        let tabBarController = self.window?.rootViewController as? UITabBarController,
//                        let navController = tabBarController.selectedViewController as? UINavigationController {
//                            let dataModel = PostDataModel()
//                            dataModel.postId = postId
//                            postDetailVC.dataModel = dataModel
//                            navController.popViewController(animated: false)
//                            navController.pushViewController(postDetailVC, animated: true)
//                    }
//                }
//            }
//        }
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                let author = alert["title"] as? String ?? ""
                let quote = alert["body"] as? String ?? ""
                print("Author: \(author)\nQuote: \(quote)")
                
                let newQuote: Quote = Quote(quote: quote as String, author: author as String)
                
                let rootViewController = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let quoteViewController = storyBoard.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
                quoteViewController.quotes = [newQuote]
                rootViewController.pushViewController(quoteViewController, animated: true)
                
            } else if let quote = aps["alert"] as? NSString {
                let newQuote: Quote = Quote(quote: quote as String, author: "")
                
                let rootViewController = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let quoteViewController = storyBoard.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
                quoteViewController.quotes = [newQuote]
                rootViewController.pushViewController(quoteViewController, animated: true)
            }
        }
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "TIFT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification: \(response.notification.request.content.userInfo)")
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
