//
//  TDView.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit

class TDView: UIView {
    public var didSetConstraints = false

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: User Interface
    private func setupUI() {
        
        backgroundColor = .clear
    }
}
