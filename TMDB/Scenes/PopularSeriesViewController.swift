//
//  PopularSeriesViewController.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import UIKit
import RxSwift

public final class PopularSeriesViewController: UICollectionViewController {
    
    public let viewModel: PopularSeriesViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: PopularSeriesViewModel) {
        self.viewModel = viewModel
        let layout = MoviesCollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureCollectionView()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = PopularSeriesViewModel.Input()
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.popularTVShows
            .debug()
            .drive()
            .disposed(by: disposeBag)
    }
    
    private func configureNavigationItem() {
        title = "TMDB"
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: "MovieCollectionViewCell"
        )
    }
}


extension PopularSeriesViewController {
    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        return cell
    }
    
}
