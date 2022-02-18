//
//  TDTableViewCell.swift
//  TeaDo
//
//  Created by Utku Eray on 13.02.2022.
//

import Foundation
import UIKit

class TDTableViewCell: UITableViewCell {
    var didSetConstraints: Bool!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = TDColor.clearColor
        self.didSetConstraints = false
    }
    
}
