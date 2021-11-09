//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

public class MovieDetailViewController: UIViewController {
    
    private lazy var movieView = makeMovieView()
    
    private let disposeBag = DisposeBag()
    public let viewModel: MovieDetailViewModel
    
    public init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureMovieView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = MovieDetailViewModel.Input()
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.movieDriver
            .drive(onNext: { [unowned self] item in
                navigationItem.title = item.title
                movieView.bind(item: item)
            }).disposed(by: disposeBag)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureMovieView() {
        view.addSubview(movieView)
        let safeArea = view.safeAreaLayoutGuide
        movieView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        movieView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        movieView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        movieView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5).isActive = true
    }
}


extension MovieDetailViewController {
    
    private func makeMovieView()-> MovieView {
        let movieView = MovieView()
        movieView.clipsToBounds = true
        movieView.translatesAutoresizingMaskIntoConstraints = false
        return movieView
    }

}
