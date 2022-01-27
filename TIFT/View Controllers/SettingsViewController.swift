//
//  SettingsViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/26/22.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var sections: [SettingSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData() {
        sections = [.notifications,
                    .review,
                    .share,
                    .contact,
                    .widget,
                    .privacy]
        
        let settingsTableViewCell = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        table.register(settingsTableViewCell, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as? SettingsTableViewCell
        let section = sections[indexPath.row]
        cell?.titleLabel.text = title(_forSection: section)
        cell?.iconImageView.image = UIImage(named: section.rawValue)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        switch section {
        case .notifications:
            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            break
        case .widget:
            break
        case .favorties:
            break
        case .share:
            let text = "Hey, you should check out the TIFT app. It's full of inspiring quotes."
            let textToShare = [ text] as [Any]
            
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
            break
        case .contact:
            self.openWebLink(url: "https://www.oaklandsoftwareco.com/contact")
            break
        case .review:
            break
        case .privacy:
            self.openWebLink(url: "https://www.oaklandsoftwareco.com/privacy")
            break
        }
    }
    
    //MARK: - Helpers
    func title(_forSection section:SettingSection) -> String {
        switch section {
        case .notifications:
            return "Notifications"
        case .widget:
            return "Widget"
        case .favorties:
            return "TIFT Favorites"
        case .share:
            return "Share TIFT"
        case .contact:
            return "Contact Us"
        case .review:
            return "Leave us a Review"
        case .privacy:
            return "Privacy Policy"
        }
    }
    
    func openWebLink(url:String) {
        let url = URL.init(string: url)
        let safari = SFSafariViewController.init(url: url!)
        safari.delegate = self
        safari.modalPresentationCapturesStatusBarAppearance = true
        safari.view.tintColor = self.view.tintColor
        self.present(safari, animated: true, completion: nil)
    }
}

enum SettingSection: String {
    case notifications = "notifications"
    case widget = "widget"
    case favorties = "favorites"
    case share = "share"
    case contact = "contact"
    case review = "review"
    case privacy = "privacy"
    
}
