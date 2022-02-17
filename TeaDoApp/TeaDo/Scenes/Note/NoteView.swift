//
//  NoteView.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NoteView: TDView {

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
        addSubview(backButton)
        addSubview(toggleLabel)
        addSubview(toggle)
        addSubview(titleTextField)
        addSubview(bodyTextView)
        
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(TDImage.backButton, for: .normal)
        return button
    }()
    
    lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = TDColor.logoColor
        toggle.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        return toggle
    }()
    
    lazy var toggleLabel: TDLabel = {
        let toggleLabel = TDLabel()
        toggleLabel.textColor = TDColor.titleColor
        toggleLabel.font = TDFont.cellSubTitleFont
        toggleLabel.backgroundColor = .clear
        toggleLabel.textAlignment = .left
        toggleLabel.numberOfLines = 1
        toggleLabel.text = NSLocalizedString("toggleTitle", comment: "")
        return toggleLabel
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = TDColor.titleColor
        textField.font = TDFont.titleFont
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("title", comment: ""),
            attributes: [NSAttributedString.Key.foregroundColor: TDColor.componentColor]
        )
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = TDColor.subTitleColor
        textView.tintColor = TDColor.componentColor
        textView.font = TDFont.bodyFont
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.text = NSLocalizedString("bodyPlaceHolder", comment: "")
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    // MARK: Methods
    func getLabelSize(with label: TDLabel) -> CGSize {
        guard var size = label.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: label.font.fontName , size: label.font.pointSize)!]) else {
            return .zero
        }
        size.width += 32.0
        return size
    }
}

// MARK: Auto Layout
extension NoteView {
    
    private func updateViewConstraints() {
        if !didSetConstraints {
            setupConstraints()
            didSetConstraints = true
        }
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
            make.left.equalTo(snp.left).offset(32)
            make.height.width.equalTo(48)
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton.snp.centerY)
            make.left.equalTo(backButton.snp.right).offset(8)
            make.right.equalTo(snp.right).offset(-16)
            make.height.equalTo(48)
        }
        
        toggleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.left.equalTo(backButton.snp.centerX)
            make.size.equalTo(getLabelSize(with: toggleLabel))
        }
        
        toggle.snp.makeConstraints { make in
            make.centerY.equalTo(toggleLabel.snp.centerY)
            make.left.equalTo(toggleLabel.snp.right)
        }
        
        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(toggleLabel.snp.bottom).offset(16)
            make.left.equalTo(backButton.snp.centerX)
            make.right.equalTo(titleTextField.snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
