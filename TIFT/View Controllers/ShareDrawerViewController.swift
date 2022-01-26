//
//  ShareDrawerViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/24/22.
//

import UIKit
import MessageUI

class ShareDrawerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var options: [ShareOption] = []
    var quote: String?
    var author: String?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    func setupData() {
        options = [.instagramStory,
                   .facebookStory,
                   .message,
                   .more,
                   .copy,
                   .speak]
        
        let shareOptionCollectionViewCell = UINib(nibName: "ShareOptionCollectionViewCell", bundle: nil)
        collectionView.register(shareOptionCollectionViewCell, forCellWithReuseIdentifier: "ShareOptionCollectionViewCell")
    }

    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareOptionCollectionViewCell", for: indexPath) as? ShareOptionCollectionViewCell
        let option = options[indexPath.row]
        cell?.titleLabel.text = option.rawValue.capitalized
        cell?.iconImageView.image = UIImage(named: option.rawValue)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        switch options[indexPath.row] {
        case .message:
            sendMessage()
            break
        case .instagramStory:
            shareIGStory()
            break
        case .facebookStory:
            shareFacebookStory()
            break
        case .save:
            break
        case .more:
            share()
            break
        case .copy:
            UIPasteboard.general.string = "\(quote!)\n\(author ?? "")"
            let message = "Copied to clipboard"
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.present(alert, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            break
        case .speak:
            readText()
            break
        }
    }
    
    // MARK: - Actions
    func share() {
        var sharingContent: [Any] = []
        if let quote = quote {
            sharingContent.append(quote)
        }
        if let author = author {
            sharingContent.append(author)
        }
        sharingContent.append(image!)
        
        let activityViewController = UIActivityViewController(activityItems: sharingContent, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func shareIGStory() {
        guard let instagramUrl = URL(string: "instagram-stories://share") else {
            return
        }

        if UIApplication.shared.canOpenURL(instagramUrl) {
            let pasterboardItems: [String: Any] = [
                "com.instagram.sharedSticker.backgroundImage": image?.jpegData(compressionQuality: 1.0) as Any
            ]
            
            UIPasteboard.general.setItems([pasterboardItems])
            UIApplication.shared.open(instagramUrl)
        } else {
            let alert = UIAlertController(title: "", message: "Could not open Instagram", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func shareFacebookStory() {
        guard let instagramUrl = URL(string: "facebook-stories://share") else {
            return
        }

        if UIApplication.shared.canOpenURL(instagramUrl) {
            let pasterboardItems: [String: Any] = [
                "com.facebook.sharedSticker.backgroundImage": image?.jpegData(compressionQuality: 1.0) as Any,
                "com.facebook.sharedSticker.appID": "515583086440216"
            ]
            
            UIPasteboard.general.setItems([pasterboardItems])
            UIApplication.shared.open(instagramUrl)
        } else {
            let alert = UIAlertController(title: "", message: "Could not open Instagram", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func sendMessage() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        composeVC.view.tintColor = UIColor.label

        composeVC.body = "\(quote!)\n\(author ?? "")\n\n- TIFT"
        composeVC.addAttachmentData((image?.jpegData(compressionQuality: 1.0))!, typeIdentifier: "public.data", filename: "image.jpeg")

        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func readText() {
        let notificationDict: [String: String?] = ["text": quote]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readText"),
                                        object: nil,
                                        userInfo: notificationDict as [AnyHashable : Any])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

enum ShareOption: String {
    case message = "message"
    case instagramStory = "story"
    case facebookStory = "facebook"
    case save = "save"
    case more = "more"
    case copy = "copy text"
    case speak = "speak"
}
