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
        let sectionItem = sectionItems[indexPath.item]
        switch sectionItem {
        case .movie(let movieViewModel):
            let cell = collectionView.dequeueReusableCell(ofType: MovieCollectionViewCell.self, at: indexPath)
            cell.bind(item: movieViewModel)
            return cell
        case .state(let loadingState):
            let cell = collectionView.dequeueReusableCell(ofType: StateCollectionViewCell.self, at: indexPath)
            cell.bind(state: loadingState)
            cell.retryButton.rx.tap
                .bind(to: nextPageTrigger)
                .disposed(by: cell.rx.reuseBag)
            return cell
        }
    }
}
