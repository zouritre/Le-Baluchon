//
//  ExtensionViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 10/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0/255.0, green: 149.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}
