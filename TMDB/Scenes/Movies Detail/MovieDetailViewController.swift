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
    private lazy var overviewLabel = makeOverviewLabel()
    private lazy var scrollView = makeScrollView()
    
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
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = MovieDetailViewModel.Input()
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.movieDriver
            .drive(onNext: { [unowned self] item in
                navigationItem.title = item.title
                movieView.bind(item: item)
                overviewLabel.text = item.overview
            }).disposed(by: disposeBag)
    }
}


// MARK: - View Configuration

extension MovieDetailViewController {
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        configureScrollView()
        configureMovieView()
        configureOverviewLabel()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        let safeArea = view.safeAreaLayoutGuide
        scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    private func configureMovieView() {
        scrollView.addSubview(movieView)
        let layoutGuide = scrollView.contentLayoutGuide
        movieView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        movieView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        movieView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        movieView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5).isActive = true
        movieView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        movieView.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func configureOverviewLabel() {
        scrollView.addSubview(overviewLabel)
        let layoutGuide = scrollView.contentLayoutGuide
        overviewLabel.topAnchor.constraint(equalTo: movieView.bottomAnchor, constant: 20.0).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 24.0).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -20.0).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}


// MARK:-  View Factory

extension MovieDetailViewController {
    
    private func makeMovieView()-> MovieView {
        let movieView = MovieView()
        movieView.clipsToBounds = true
        movieView.translatesAutoresizingMaskIntoConstraints = false
        return movieView
    }
    
    private func makeOverviewLabel()-> UILabel {
        let overviewLabel = UILabel()
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = UIColor.secondaryLabel
        overviewLabel.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        return overviewLabel
    }
    
    private func makeScrollView()->UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
}
