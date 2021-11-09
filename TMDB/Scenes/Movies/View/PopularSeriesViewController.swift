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
    
    private var dataSource: MoviesDataSource!
    private let disposeBag = DisposeBag()
    public let viewModel: PopularSeriesViewModel
    internal let nextPageTrigger = PublishSubject<Void>()
    
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
        
        configureView()
        configureDataSource()
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
        
        let output = viewModel.transform(
            input: input,
            disposeBag: disposeBag
        )
        
        output.popularMovies
            .drive(dataSource.rx.sectionItems)
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        title = "TMDB"
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.systemBackground
    }
    
    private func configureDataSource() {
        self.dataSource = MoviesDataSource(collectionView: collectionView)
        dataSource.onRetryButtonTapped
            .bind(to: nextPageTrigger)
            .disposed(by: disposeBag)
    }
}
