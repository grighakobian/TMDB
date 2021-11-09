//
//  PopularSeriesViewController+UICollectionViewDataSource.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import UIKit

extension PopularSeriesViewController {
    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItems.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: MovieCollectionViewCell.self, at: indexPath)
        cell.bind(item: sectionItems[indexPath.item])
        return cell
    }
}
