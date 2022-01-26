//
//  HighlightedQuoteCollectionViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/6/22.
//

import UIKit

class HighlightedQuoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.containerView.layer.cornerRadius = 10
        self.containerView.clipsToBounds = true
        self.containerView.layoutIfNeeded()
        
//        self.containerView.layer.borderWidth = 1.0
        self.containerView.layer.borderColor = UIColor.white.cgColor
    }
    
    override func prepareForReuse() {
        quoteLabel.text = nil
        authorLabel.text = nil
    }

}
