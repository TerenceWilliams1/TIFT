//
//  CategoriesTableViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/8/22.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var categories: [Category]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let categoryCollectionViewCell = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(categoryCollectionViewCell, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.reloadData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categories = nil
    }
    
    //MARK: - Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell
        
        if let category = categories?[indexPath.row] {
            cell?.titleLabl.text = category.title
            cell?.iconView.image = UIImage(named: "")
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories![indexPath.row]
        let notificationDict: [String: Any] = ["quotes": category.quotes, "index": 0]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "exploreQuotes"),
                                        object: nil,
                                        userInfo: notificationDict)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionView.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collectionView.scrollToNearestVisibleCollectionViewCell()
        }
    }

    
}
