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
    func configure(isNote: Bool, isCompleted: Bool) {
        self.didSetConstraints = false
        self.isNote = isNote
        self.isCompleted = isCompleted
        
        self.statusButton.isHidden = isNote

        if !isNote {
            self.statusButton.isSelected = isCompleted
        }
        
        setupUI()
    }
    
    func setupTexts(title:String, subTitle:String, strikeThrough: Bool) {
        let titleStrikeThrough =  NSMutableAttributedString(string: title)
        titleStrikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, titleStrikeThrough.length))

        let subTitleStrikeThrough =  NSMutableAttributedString(string: subTitle)
        subTitleStrikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, subTitleStrikeThrough.length))

        let titleRemovedAttributes =  NSMutableAttributedString(string: title)
        titleRemovedAttributes.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, titleRemovedAttributes.length))

        let subTitleRemovedAttributes =  NSMutableAttributedString(string: subTitle)
        subTitleRemovedAttributes.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, subTitleRemovedAttributes.length))
        
        if strikeThrough {
            self.titleLabel.attributedText = titleStrikeThrough
            self.subTitleLabel.attributedText = subTitleStrikeThrough
        } else {
            self.titleLabel.attributedText = titleRemovedAttributes
            self.subTitleLabel.attributedText = subTitleRemovedAttributes
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: setupUI
    private func setupUI() {
        self.backgroundColor = .clear
        
        contentView.addSubview(statusButton)
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
        
        statusButton.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-16)
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right).offset(-48)
            make.height.equalTo(30)
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
