//
//  TDNavigationController.swift
//  TeaDo
//
//  Created by Utku Eray on 10.02.2022.
//

import Foundation
import UIKit

class TDNavigationController: UINavigationController {
    
    init(rootViewController: UIViewController, backgroundColor: UIColor = TDColor.navigationBarColor) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.setBackgroundImage(UIImage(color: backgroundColor), for: .default)
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
    
    // Enable landscape mode only for iPad, both iPhone and iPad can user Portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.portrait
        } else {
            return UIInterfaceOrientationMask.landscape
        }
    }
}

extension UINavigationController {
    
    // Should be called from ViewControllers to update navigation bar
    public func updateBackgroundColor(backgroundColor: UIColor) {
        self.navigationBar.setBackgroundImage(UIImage(color: backgroundColor), for: .default)
        self.navigationBar.tintColor = TDColor.componentColor
        self.navigationBar.shadowImage = UIImage(color: backgroundColor)
        self.navigationBar.setBackgroundImage(UIImage(color: backgroundColor), for: .default)
        self.navigationBar.backgroundColor = backgroundColor
        self.navigationBar.barTintColor = backgroundColor
        self.navigationBar.isTranslucent = false
        self.navigationBar.isOpaque = true
    }
}

extension UIImage {
    // Extension to use UIColor as UIImage
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
