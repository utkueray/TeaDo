//
//  TDHUDManager.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//

import Foundation
import ProgressHUD

public class TDHUDManager {
    static let shared = TDHUDManager()
    
    init() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorAnimation = TDColor.darkComponentColor
    }
    
    public func showHUD() {
        ProgressHUD.show()
    }
    
    public func hideHUD() {
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
