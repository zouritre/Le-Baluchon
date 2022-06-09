//
//  WeatherViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 22/05/2022.
//

import UIKit

extension WeatherViewController {
    
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

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return WeatherDataCell.getCell(for: indexPath, in: collectionView)
    }
    
    
    
}
class WeatherViewController: UIViewController {

    var menuItemLyon = UIKeyCommand(title: "Lyon",
                                                   action: #selector(selectCity(_:)),
                                                   input: "L",
                                                   modifierFlags: .command)
    
    var menuItemNY = UIKeyCommand(title: "New York",
                                  action: #selector(selectCity(_:)),
                                  input: "N",
                                  modifierFlags: .command)
    
    var menuItems: [UIKeyCommand] = []
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add designated cities as menu items
        menuItems.append(menuItemLyon)
        menuItems.append(menuItemNY)

        // Create city button menu
        let citySelectionMenu = UIMenu(title: "Sélectionnez une ville", options: .destructive, children: [menuItemNY, menuItemLyon])
        
        citySelectionButton.menu = citySelectionMenu
        
    }
    
    @IBOutlet weak var weatherDetails: UICollectionView!
    
    @IBOutlet weak var citySelectionButton: UIButton!
    
    ///  Set selected menu item state to on and disable the one previously selected
    /// - Parameter sender: The selected menu item
    @objc func selectCity(_ sender: UIKeyCommand) {
        
        // Set the selected item state to on
        menuItems.forEach{ item in
            
            if item.title == sender.title {
                // Set the selected item state to on
                item.state = .on
                
            }
            else {
                // Set the other items state to off
                item.state = .off
                
            }
            
        }
        
        // Recreate the button menu with new items while preserving its configuration
        citySelectionButton.menu = citySelectionButton.menu?.replacingChildren(menuItems)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
