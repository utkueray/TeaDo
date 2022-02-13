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
        addSubview(tableView)
        
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    lazy var tableView: TDTableView = {
        let tableView = TDTableView()
        
        tableView.register(ToDoCell.self, forCellReuseIdentifier: String(describing: ToDoCell.self))
        return tableView
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
        tableView.snp.makeConstraints({ (make) in
            make.top.equalTo(snp.topMargin)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        })
    }
}
