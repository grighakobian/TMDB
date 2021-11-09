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
        collectionView.register(MovieCollectionViewCell.self)
    }
    
    // MARK: DataSource
    
    func setSectionItems(_ newSectionItems: [MovieItemViewModel]) {
        let changeset = StagedChangeset(source: sectionItems, target: newSectionItems)
        collectionView.reload(using: changeset) { newSectionItems in
            self.sectionItems = newSectionItems
        }
    }
}


extension Reactive where Base: PopularSeriesViewController {
    
    public var error: Binder<Error> {
        return Binder(self.base) { viewController, error in
            let label = InsetLabel()
            label.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
            label.textColor = .secondaryLabel
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            viewController.collectionView.backgroundView = label
        }
    }
}
