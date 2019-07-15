//
//  ItemsViewCell.swift
//  CoreDataTest
//
//  Created by Fivecode on 15/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit

class ItemsViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configureCell(item: Item) {
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price)"
        detailLabel.text = item.details
    }
    
}
