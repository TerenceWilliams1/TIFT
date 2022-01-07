//
//  QuoteTableViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/5/22.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var socialStack: UIStackView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var quoteIndexPath = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        quoteLabel.text = nil
        authorLabel.text = nil
        quoteIndexPath = IndexPath.init()
    }

    //MARK: - Actions
    @IBAction func saveQuote() {
        socialStack.isHidden = true
        let notificationDict: [String: IndexPath] = ["indexPath": quoteIndexPath]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveQuote"),
                                        object: nil,
                                        userInfo: notificationDict)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.socialStack.isHidden = false
        }
    }
    
    @IBAction func shareQuote() {
        let notificationDict: [String: String] = ["quote": quoteLabel.text!, "author": authorLabel.text!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "shareQuote"),
                                        object: nil,
                                        userInfo: notificationDict)
    }
}
