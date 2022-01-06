//
//  QuoteTableViewCell.swift
//  TIFT
//
//  Created by Terence Williams on 1/5/22.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        quoteLabel.text = nil
        authorLabel.text = nil
    }

}
