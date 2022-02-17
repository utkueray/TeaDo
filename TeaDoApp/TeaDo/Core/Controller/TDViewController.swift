//
//  TDViewController.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import UIKit

class TDViewController: UIViewController {
    public var didSetConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backIndicatorImage = TDImage.backButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = TDImage.backButton
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationItem.titleView = generateTitleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.portrait
        } else {
            return UIInterfaceOrientationMask.landscape
        }
    }
    
    //MARK: Methods
    
    func generateTitleView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 24))
        let imageView = UIImageView(image: TDImage.logo)
        
        let titleLabel = TDLabel()
        titleLabel.font = TDFont.titleFont
        titleLabel.textColor = TDColor.subTitleColor
        titleLabel.text = NSLocalizedString("appName", comment: "")
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.left.equalTo(view.snp.left)
            make.width.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(4)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(32)
        }
        
        return view
    }
}

// MARK: - AlertController
extension TDViewController {
    public func showError(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - HUD
extension TDViewController {
    public func showHUD() {
        TDHUDManager.shared.showHUD()
    }
    
    public func hideHUD() {
        TDHUDManager.shared.hideHUD()
    }
    
    public func successHUD() {
        TDHUDManager.shared.successHUD()
    }
    
    public func addHUD() {
        TDHUDManager.shared.addHUD()
    }
    
    public func errorHUD() {
        TDHUDManager.shared.errorHUD()
    }
}
