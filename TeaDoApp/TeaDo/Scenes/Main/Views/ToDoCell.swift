//
//  ToDoCell.swift
//  TeaDo
//
//  Created by Utku Eray on 13.02.2022.
//

import Foundation
import UIKit

class ToDoCell: TDTableViewCell {
    
    var isNote: Bool!
    var isCompleted: Bool!
    
    var statusButton: UIButton = {
        let button = UIButton()
        button.setImage(TDImage.logo?.withTintColor(.white), for: .normal)
        button.setImage(TDImage.logo?.withTintColor(TDColor.logoColor), for: .selected)
        return button
    }()
    
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
    func configure(title: String?, subtitle: String?, isNote: Bool, isCompleted: Bool) {
        self.didSetConstraints = false
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
        self.isNote = isNote
        self.isCompleted = isCompleted
        
        if !isNote {
            statusButton.isSelected = isCompleted
        }
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.subTitleLabel.text = ""
        self.isNote = false
        self.isCompleted = false
    }
    
    // MARK: setupUI
    private func setupUI() {
        self.backgroundColor = .clear
        
        if !self.isNote {
            contentView.addSubview(statusButton)
        }
        
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
        
        if !self.isNote {
            statusButton.snp.makeConstraints { make in
                make.centerY.equalTo(snp.centerY)
                make.left.equalTo(snp.left)
                make.height.width.equalTo(24)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(snp.top)
                make.left.equalTo(statusButton.snp.right).offset(8)
                make.right.equalTo(snp.right).offset(-32)
                make.height.equalTo(30)
            }
        } else {
            if contentView.subviews.contains(statusButton) {
                statusButton.removeFromSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(snp.top)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right).offset(-32)
                make.height.equalTo(30)
            }
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel.snp.left)
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
