//
//  WeatherDataCell.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 08/06/2022.
//

import Foundation
import UIKit

enum WeatherDataCell: Int {
    
    case wind = 0
    case sun = 1
    case feels_like = 2
    case pressure = 3
    case humidity = 4
    case visibility = 5
    
    static func getCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        
        switch indexPath.item {
            
        case 0: return collectionView.dequeueReusableCell(withReuseIdentifier: "wind", for: indexPath)
        case 1: return collectionView.dequeueReusableCell(withReuseIdentifier: "sun", for: indexPath)
        
        case 2: return collectionView.dequeueReusableCell(withReuseIdentifier: "feels_like", for: indexPath)
            
        case 3: return collectionView.dequeueReusableCell(withReuseIdentifier: "pressure", for: indexPath)
            
        case 4: return collectionView.dequeueReusableCell(withReuseIdentifier: "humidity", for: indexPath)
            
        case 5: return collectionView.dequeueReusableCell(withReuseIdentifier: "visibility", for: indexPath)
            
        default: return collectionView.dequeueReusableCell(withReuseIdentifier: "wind", for: indexPath)
            
        }
    }
}
