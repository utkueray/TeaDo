//
//  TDNavigationController.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import Foundation
import UIKit

class TDNavigationController: UINavigationController {
    
    init(rootViewController: UIViewController, bacgroundColor: UIColor = .gray) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.setBackgroundImage(UIImage(color: bacgroundColor), for: .default)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
}

extension UINavigationController {
    
    public func updateBackgroundColor(bacgroundColor: UIColor) {
        self.navigationBar.setBackgroundImage(UIImage(color: bacgroundColor), for: .default)
        self.navigationBar.shadowImage = UIImage(color: bacgroundColor)
        self.navigationBar.backgroundColor = bacgroundColor
        self.navigationBar.isOpaque = true
    }
    
    public func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        for viewController in viewControllers.reversed() where viewController.isKind(of: ofClass) {
            popToViewController(viewController, animated: animated)
            break
        }
    }
    
    public func hasViewController(ofClass: AnyClass) -> Bool {
        for viewController in viewControllers where viewController.isKind(of: ofClass) {
            return true
        }
        return false
    }
}

extension UIImage {
    convenience init?(color: UIColor) {
        self.init()
        guard let maskImage = self.cgImage else { return nil }
        
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        guard let bitmapContext = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return nil }
        
        bitmapContext.clip(to: bounds, mask: maskImage)
        bitmapContext.setFillColor(color.cgColor)
        bitmapContext.fill(bounds)
        
        guard let cImage = bitmapContext.makeImage() else { return nil }
        let coloredImage = UIImage(cgImage: cImage)
    
        self.init(cgImage: coloredImage.cgImage!)
    }
}
