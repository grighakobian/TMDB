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
    private lazy var headingLabel = makeHeadingLabel()
    private lazy var containerView = makeContainerView()
    private lazy var collectionView = makeCollectionView()
    private lazy var stackView = makeStackView()
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
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        let safeArea = view.safeAreaLayoutGuide
        scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        let layoutGuide = scrollView.contentLayoutGuide
        stackView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor).isActive = true
        
        stackView.addArrangedSubview(movieView)
        stackView.addArrangedSubview(overviewLabel)
        movieView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5).isActive = true
        
        containerView.addSubview(headingLabel)
        containerView.addSubview(collectionView)
        stackView.addArrangedSubview(containerView)
        containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        headingLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        headingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}


// MARK:-  View Factory

extension MovieDetailViewController {
    
    private func makeStackView()-> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func makeMovieView()-> MovieView {
        let movieView = MovieView()
        movieView.clipsToBounds = true
        movieView.translatesAutoresizingMaskIntoConstraints = false
        return movieView
    }
    
    private func makeOverviewLabel()-> InsetLabel {
        let overviewLabel = InsetLabel()
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = UIColor.secondaryLabel
        overviewLabel.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        overviewLabel.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        return overviewLabel
    }
    
    private func makeScrollView()-> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    private func makeContainerView()-> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        return containerView
    }
    
    private func makeHeadingLabel()-> InsetLabel {
        let label = InsetLabel()
        label.text = "You may also like"
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.textInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeCollectionView()-> UICollectionView {
        let layout = MoviesCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .quaternarySystemFill
        collectionView.register(MovieCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
}
