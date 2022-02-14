//
//  ToDoCell.swift
//  TeaDo
//
//  Created by Utku Eray on 13.02.2022.
//

import Foundation
import UIKit

class ToDoCell: TDTableViewCell {
        
    var titleLabel: TDLabel = {
        let label = TDLabel()
        label.textColor = TDColor.darkTitleColor
        label.font = TDFont.cellTitleFont
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    var subTitleLabel: TDLabel = {
        let label = TDLabel()
        label.textColor = TDColor.darkSubTitleColor
        label.font = TDFont.cellSubTitleFont
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    var seperator: TDView = {
        let view = TDView()
        view.backgroundColor = TDColor.darkComponentColor
        return view
    }()
    
    // MARK: Methods
    func configure(title: String?, subtitle: String?) {
        self.didSetConstraints = false
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle

        setupUI()
    }
    
    // MARK: setupUI
    private func setupUI() {
        self.backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(seperator)
        
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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right).offset(-32)
            make.height.equalTo(30)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(24)
        }
        
        seperator.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(2)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(1)
        }
    }
}
