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
    }
    
    override func prepareForReuse() {
        themeImageView.image = nil
    }

}
