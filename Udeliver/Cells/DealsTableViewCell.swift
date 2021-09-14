//
//  DealsTableViewCell.swift
//  Udeliver
//
//  Created by Surgeont on 02.09.2021.
//

import UIKit

class DealsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var fromAddressLabel: UILabel!
    
    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var dealModel: FirebaseDeal? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        
        guard let dealModel = dealModel else { return }
            
        fromAddressLabel.text = "Откуда: \(dealModel.fromAddress)"
        toAddressLabel.text = "Куда: \(dealModel.toAddress)"
        priceLabel.text = "\(dealModel.price)₽"
        statusLabel.text = dealModel.status
        
    }
    
}
