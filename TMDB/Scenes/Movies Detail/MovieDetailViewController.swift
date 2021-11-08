//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import UIKit

public class MovieDetailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.sd_imageTransition = .fade(duration: 0.2)
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    private let viewModel: MovieDetailViewModel
    
    public init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    
    private func configureViews() {
        view.addSubview(imageView)
        view.addSubview(gradientView)
        view.addSubview(titleLabel)
        view.addSubview(averageRatingLabel)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24.0).isActive = true
        
        gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        
        averageRatingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0).isActive = true
        averageRatingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0).isActive = true
        averageRatingLabel.widthAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
}
