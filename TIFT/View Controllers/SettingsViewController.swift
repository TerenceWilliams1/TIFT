//
//  SettingsViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/26/22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
                    .terms,
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
            break
        case .widget:
            break
        case .favorties:
            break
        case .share:
            break
        case .contact:
            break
        case .review:
            break
        case .terms:
            break
        case .privacy:
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
        case .terms:
            return "Terms & Conditions"
        case .privacy:
            return "Privacy Policy"
        }
    }
}

enum SettingSection: String {
    case notifications = "notifications"
    case widget = "widget"
    case favorties = "favorites"
    case share = "share"
    case contact = "contact"
    case review = "review"
    case terms = "terms"
    case privacy = "privacy"
    
}
