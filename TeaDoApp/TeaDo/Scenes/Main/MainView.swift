//
//  MainView.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit
import SnapKit

class MainView: TDView {

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
        addSubview(label)
        
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    lazy var label: TDLabel = {
        let label = TDLabel()
        label.text = "MainView"
        label.textAlignment = .center
        label.accessibilityIdentifier = "label"
        return label
    }()
}

// MARK: Auto Layout
extension MainView {
    
    private func updateViewConstraints() {
        if !didSetConstraints {
            setupConstraints()
            didSetConstraints = true
        }
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.bottom.equalTo(snp.bottom)
            make.right.equalTo(snp.right)
        })
    }
}
