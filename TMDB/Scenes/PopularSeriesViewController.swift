//
//  PopularSeriesViewController.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import UIKit
import RxSwift

public final class PopularSeriesViewController: UIViewController {
    
    public let viewModel: PopularSeriesViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: PopularSeriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
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
}
