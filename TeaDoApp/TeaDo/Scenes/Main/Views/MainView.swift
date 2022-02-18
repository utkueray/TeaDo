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
        addSubview(backgroundView)
        addSubview(tableView)
        addSubview(toolBar)
        addSubview(addButton)
        addSubview(dataLabel)
        
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    lazy var tableView: TDTableView = {
        let tableView = TDTableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = TDColor.clearColor
        
        tableView.register(ToDoCell.self, forCellReuseIdentifier: String(describing: ToDoCell.self))
        return tableView
    }()
    
    lazy var backgroundView: TDView = {
        let view = TDView()
        view.backgroundColor = TDColor.backgroundColor
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        button.tintColor = TDColor.titleColor
        return button
    }()
    
    lazy var dataLabel: TDLabel = {
        let label = TDLabel()
        label.textColor = TDColor.componentColor
        label.font = TDFont.cellSubTitleFont
        label.backgroundColor = TDColor.clearColor
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var toolBar: TDView = {
        let view = TDView()
        view.backgroundColor = TDColor.componentColor
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
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
        toolBar.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
            make.height.equalTo(80)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(toolBar.snp.top).offset(16)
            make.right.equalTo(toolBar.snp.right).offset(-32)
            make.width.height.equalTo(24)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.centerX.equalTo(toolBar.snp.centerX)
            make.top.equalTo(addButton.snp.top)
            make.right.equalTo(addButton.snp.left).offset(-16)
            make.left.equalTo(snp.left).offset(72)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(toolBar.snp.top)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.topMargin)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.bottom.equalTo(toolBar.snp.top)
        }
    }
}
