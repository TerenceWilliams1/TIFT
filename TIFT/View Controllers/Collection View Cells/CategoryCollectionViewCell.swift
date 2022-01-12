//
//  CategoryCollectionViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/8/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
    }

}
