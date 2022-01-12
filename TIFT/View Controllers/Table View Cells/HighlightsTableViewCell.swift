//
//  HighlightsTableViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/8/22.
//

import UIKit

class HighlightsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var quotes: [Quote]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let highlightedCollectionCellNib = UINib(nibName: "HighlightedQuoteCollectionViewCell", bundle: nil)
        collectionView.register(highlightedCollectionCellNib, forCellWithReuseIdentifier: "HighlightedQuoteCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.reloadData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        quotes = nil
    }
    
    //MARK: - Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quotes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightedQuoteCollectionViewCell", for: indexPath) as? HighlightedQuoteCollectionViewCell
        
        if let highlight = quotes?[indexPath.row] {
            cell?.quoteLabel.text = highlight.quote
            cell?.authorLabel.text = highlight.author
            cell?.containerView.backgroundColor = UIColor.peach
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let notificationDict: [String: Any] = ["quotes": quotes!,
                                               "index": indexPath.row,
                                               "color": UIColor.peach!]
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
