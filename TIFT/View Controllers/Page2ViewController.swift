//
//  Page2ViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/27/22.
//

import UIKit
import OneSignal

class Page2ViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 5
        actionButton.addTarget(self, action: #selector(closeWalkthrough), for: .touchUpInside)
    }
    
    @objc func closeWalkthrough() {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.registerNotifications()
                DispatchQueue.main.async {
                    self.actionButton.setTitle("Continue →", for: .normal)
                }
            default:
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeWalkthrough"),
                    object: nil,
                    userInfo: nil)
                }
            }
        })
    }
    
    // MARK: - Notifications
    func registerNotifications() {
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            if accepted {
                UIApplication.shared.registerForRemoteNotifications()
            }
        })
    }
}
