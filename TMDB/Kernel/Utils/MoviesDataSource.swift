//
//  MoviesDataSource.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 09.11.21.
//

import RxSwift
import DifferenceKit
import SDWebImage

protocol MoviesDataSourceType: AnyObject {
    var sectionItems: [SectionItem] { get }
    func setSectionItems(_ newSectionItems: [SectionItem])
    
    /// Triggers when user taps on retry button in the cell
    var onRetryButtonTapped: PublishSubject<Void> { get }
}

public class MoviesDataSource: NSObject, MoviesDataSourceType  {
    
    private(set) var sectionItems: [SectionItem]
    private(set) weak var collectionView: UICollectionView!
    private(set) var onRetryButtonTapped: PublishSubject<Void>
    
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.sectionItems = [SectionItem]()
        self.onRetryButtonTapped = PublishSubject<Void>()
        super.init()
        
        self.collectionView.dataSource = self
        self.collectionView.prefetchDataSource = self
        self.collectionView.register(MovieCollectionViewCell.self)
        self.collectionView.register(StateCollectionViewCell.self)
    }
    
    func setSectionItems(_ newSectionItems: [SectionItem]) {
        let changeset = StagedChangeset(source: sectionItems, target: newSectionItems)
        collectionView.reload(using: changeset) { newSectionItems in
            self.sectionItems = newSectionItems
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MoviesDataSource: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
                .bind(to: onRetryButtonTapped)
                .disposed(by: cell.rx.reuseBag)
            return cell
        }
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension MoviesDataSource: UICollectionViewDataSourcePrefetching {
    
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = indexPaths
            .map({ sectionItems[$0.item].movieViewModel?.posterImageUrl })
            .compactMap({ $0 })
        SDWebImagePrefetcher.shared.prefetchURLs(urls)
    }
}


// MARK - Raactive

extension Reactive where Base: MoviesDataSourceType {
    
    internal var sectionItems: Binder<[SectionItem]> {
        return Binder(self.base) { dataSource, sectionItems in
            base.setSectionItems(sectionItems)
        }
    }
}
