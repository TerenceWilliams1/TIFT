//
//  ShareOptionCollectionViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/25/22.
//

import UIKit

class ShareOptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
    }

}
