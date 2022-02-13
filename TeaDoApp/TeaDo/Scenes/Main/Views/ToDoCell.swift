//
//  ToDoCell.swift
//  TeaDo
//
//  Created by Utku Eray on 13.02.2022.
//

import Foundation
import UIKit

class ToDoCell: TDTableViewCell {
        
    var label: TDLabel = {
        let label = TDLabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Methods
    func configure(text:String) {
        self.didSetConstraints = false
        self.label.text = text
        
        setupUI()
    }
    
    // MARK: setupUI
    private func setupUI() {
        self.backgroundColor = .clear
        
        contentView.addSubview(self.label)
        
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
}

// MARK: Auto Layout
extension ToDoCell {
    
    private func updateViewConstraints() {
        if !didSetConstraints {
            setupConstraints()
            didSetConstraints = true
        }
    }
    
    private func setupConstraints() {
        
        self.label.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
