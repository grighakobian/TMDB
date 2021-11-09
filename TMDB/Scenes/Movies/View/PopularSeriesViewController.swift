//
//  PopularSeriesViewController.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import UIKit
import RxSwift
import DifferenceKit

public final class PopularSeriesViewController: UICollectionViewController {
    
    public let viewModel: PopularSeriesViewModel
    
    private(set) var sectionItems = [MovieItemViewModel]()
    
    internal let nextPageTrigger = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(viewModel: PopularSeriesViewModel) {
        self.viewModel = viewModel
        let layout = MoviesCollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    // MARK: Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureCollectionView()
        
        bindViewModel()
    }
    
    // MARK: - Helpers
    
    private func bindViewModel() {
        let onMovieSelected = collectionView.rx
            .itemSelected
            .map({ $0.item })
        
        let input = PopularSeriesViewModel.Input(
            nextPageTrigger: nextPageTrigger,
            onMovieSelected: onMovieSelected
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.popularMovies
            .drive(onNext: { [unowned self] sectionItems in
                setSectionItems(sectionItems)
            }).disposed(by: disposeBag)
    }
    
    private func configureNavigationItem() {
        title = "TMDB"
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseId)
    }
    
    // MARK: DataSource
    
    func setSectionItems(_ newSectionItems: [MovieItemViewModel]) {
        let changeset = StagedChangeset(source: sectionItems, target: newSectionItems)
        collectionView.reload(using: changeset) { newSectionItems in
            self.sectionItems = newSectionItems
        }
    }
}
