//
//  BidTableViewCell.swift
//  SwipeApp
//
//  Created by Alex Li on 11/7/21.
//

import UIKit

class BidTableViewCell: UITableViewCell {

    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hallLabell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
