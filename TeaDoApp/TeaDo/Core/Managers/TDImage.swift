//
//  TDImage.swift
//  TeaDo
//
//  Created by Utku Eray on 14.02.2022.
//

import Foundation
import UIKit

/*
 Load images to struct for easy access
 */

struct TDImage {
    static let logo = UIImage(named:"leafIcon.png")?.withTintColor(TDColor.logoColor)
    static let backButton = UIImage(named:"back.png")
    static let addButton = UIImage(named: "plus")?.withTintColor(TDColor.componentColor)
}
