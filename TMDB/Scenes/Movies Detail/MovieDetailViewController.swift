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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.sd_imageTransition = .fade(duration: 0.2)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 46, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var averageRatingLabel: InsetLabel = {
        let averageRatingLabel = InsetLabel()
        averageRatingLabel.numberOfLines = 1
        averageRatingLabel.textColor = UIColor.white
        averageRatingLabel.backgroundColor = UIColor.systemPink
        averageRatingLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        averageRatingLabel.layer.cornerRadius = 4.0
        averageRatingLabel.clipsToBounds = true
        averageRatingLabel.textAlignment = .center
        averageRatingLabel.textInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        averageRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        return averageRatingLabel
    }()
    
    private lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.gradientDirection = .vertical
        let startColor = UIColor.black.withAlphaComponent(0.75)
        let endColor = UIColor.black.withAlphaComponent(0.0)
        gradientView.colors = [endColor, startColor]
        gradientView.clipsToBounds = true
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    
    private let disposeBag = DisposeBag()
    public let viewModel: MovieDetailViewModel
    
    public init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        configureViews()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = MovieDetailViewModel.Input()
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        
        output.movieDriver
            .drive(onNext: { [unowned self] item in
                navigationItem.title = item.title
                
                titleLabel.text = item.title
                imageView.sd_setImage(with: item.posterImageUrl, completed: nil)
                if let averageRating = item.averageRating {
                    averageRatingLabel.text = String(averageRating)
                } else {
                    averageRatingLabel.text = nil
                }
            }).disposed(by: disposeBag)
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(imageView)
        view.addSubview(gradientView)
        view.addSubview(titleLabel)
        view.addSubview(averageRatingLabel)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24.0).isActive = true
        
        gradientView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        
        averageRatingLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -12.0).isActive = true
        averageRatingLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 12.0).isActive = true
        averageRatingLabel.widthAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
}
