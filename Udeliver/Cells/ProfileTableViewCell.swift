//
//  ProfileTableViewCell.swift
//  Udeliver
//
//  Created by Surgeont on 06.09.2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var fromAddressLabel: UILabel!
    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var dealModel: FirebaseDeal? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        
        guard let dealModel = dealModel else { return }
            
        fromAddressLabel.text = "Откуда: \(dealModel.fromAddress)"
        toAddressLabel.text = "Куда: \(dealModel.toAddress)"
        priceLabel.text = "Стоимость: \(dealModel.price)₽"
        
    }

}
