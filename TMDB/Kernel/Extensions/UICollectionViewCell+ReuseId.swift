//
//  UICollectionViewCell+ReuseId.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseId: String = {
        return String(describing: self)
    }()
    
}
