//
//  ThemeViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/22/22.
//

import UIKit

class ThemeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var themes: [Theme] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }
    
    func setupData() {
        themes = [.dark,
                  .image1,
                  .image2,
                  .image3,
                  .image4]
        
        
        let themeCollectionViewCell = UINib(nibName: "ThemeCollectionViewCell", bundle: nil)
        collectionView.register(themeCollectionViewCell, forCellWithReuseIdentifier: "ThemeCollectionViewCell")
    }
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCollectionViewCell", for: indexPath) as? ThemeCollectionViewCell
        let theme = themes[indexPath.row]
        switch theme {
        case .dark:
            cell?.themeImageView.image = nil
            cell?.themeImageView.backgroundColor = .black
            break
        default:
            cell?.themeImageView.image = UIImage(named: theme.rawValue)
            break
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theme = themes[indexPath.row]
        let notificationDict: [String: Any] = ["theme": theme.rawValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeTheme"),
                                        object: nil,
                                        userInfo: notificationDict)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }

}

enum Theme: String {
    case dark = "dark"
    case light = "light"
    case image1 = "t1"
    case image2 = "t2"
    case image3 = "t3"
    case image4 = "t4"
}
