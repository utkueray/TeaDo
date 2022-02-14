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
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = TDColor.darkTitleColor
        textField.font = TDFont.titleFont
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: TDColor.darkComponentColor]
        )
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = TDColor.darkSubTitleColor
        textView.tintColor = TDColor.darkComponentColor
        textView.font = TDFont.bodyFont
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.text = "What's on your mind ..?"
        textView.isUserInteractionEnabled = true
        return textView
    }()
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
            make.height.equalTo(48)
            make.right.equalTo(snp.right).offset(-16)
        }
        
        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.left.equalTo(backButton.snp.left)
            make.right.equalTo(titleTextField.snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
