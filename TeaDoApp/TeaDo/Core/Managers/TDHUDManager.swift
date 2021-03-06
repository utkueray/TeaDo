//
//  TDHUDManager.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//

import Foundation
import ProgressHUD

/*
 Custom singleton class for easy to use loading animations
 */

public class TDHUDManager {
    static let shared = TDHUDManager()
    
    init() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorAnimation = TDColor.componentColor
    }
    
    public func showHUD() {
        ProgressHUD.show()
    }
    
    public func hideHUD() {
        Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(hide), userInfo: nil, repeats: false)
    }
    
    @objc private func hide() {
        ProgressHUD.dismiss()
    }
    
    public func successHUD() {
        ProgressHUD.showSucceed()
        ProgressHUD.dismiss()
    }
    
    public func addHUD() {
        ProgressHUD.showAdded()
        ProgressHUD.dismiss()
    }
    
    public func errorHUD() {
        ProgressHUD.showFailed()
        ProgressHUD.dismiss()
    }
}
