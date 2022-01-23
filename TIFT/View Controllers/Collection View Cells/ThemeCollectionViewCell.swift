//
//  ThemeCollectionViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/22/22.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var themeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        themeImageView.layer.borderColor = UIColor.white.cgColor
        themeImageView.layer.borderWidth = 0.5
    }
    
    override func prepareForReuse() {
        themeImageView.image = nil
    }

}
