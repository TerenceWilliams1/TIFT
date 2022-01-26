//
//  SettingsTableViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/26/22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        titleLabel.text = nil
    }
}
