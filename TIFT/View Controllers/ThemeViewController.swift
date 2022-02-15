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
        themes = [.image1,
                  .image2,
                  .image3,
                  .image4,
                  .valley,
                  .plants1,
                  .plants2,
                  .plants3,
                  .plants4,
                  .road,
                  .roads,
                  .road3,
                  .dark,
                  .river,
                  .lake,
                  .blue,
                  .green]
        
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
            DispatchQueue.main.async {
                cell?.themeImageView.image = UIImage(named: theme.rawValue)
            }
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }

}

enum Theme: String {
    case dark = "dark"
    case light = "light"
    case plants1 = "plants1"
    case plants2 = "plants2"
    case plants3 = "plants3"
    case plants4 = "plants4"
    case image1 = "t1"
    case image2 = "t2"
    case image3 = "t3"
    case image4 = "t4"
    case valley = "valley"
    case blue = "blue"
    case green = "green"
    case roads = "roads"
    case road = "road"
    case road3 = "road3"
    case river = "river"
    case lake = "lake"
}
