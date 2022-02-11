//
//  TDLabel.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit

class TDLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: User Interface
    private func setupUI() {
        textAlignment = .left
        numberOfLines = 0
    }
}

