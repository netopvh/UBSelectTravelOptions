//
//  DetailTravelOptionTableViewCell.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

class DetailTravelOptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblL: UILabel!
    @IBOutlet weak var lblR: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.backgroundColor = .white
    }
    
    func setInfo(left: String, right: String) {
        self.lblL.text = left
        self.lblR.text = right
        self.lblL.isHidden = right.isEmpty
        self.lblR.isHidden = right.isEmpty
    }
    
    func setFont(left: UIFont, right: UIFont) {
        self.lblL.font = left
        self.lblR.font = right
    }
    
    func setColor(left: UIColor, right: UIColor) {
        self.lblL.textColor = left
        self.lblR.textColor = right
    }
    
}
