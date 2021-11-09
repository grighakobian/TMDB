//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import UIKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 15.0
        containerView.clipsToBounds = true
        containerView.backgroundColor = .secondarySystemFill
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor.quaternarySystemFill.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }

    func bind(item: MovieRepresentable) {
        titleLabel.text = item.title
        imageView.sd_setImage(with: item.posterImageUrl, completed: nil)
        
        if let averageRating = item.averageRating {
            averageRatingLabel.text = String(averageRating)
        } else {
            averageRatingLabel.text = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        imageView.sd_cancelCurrentImageLoad()
    }
    
    private func configureShadow() {
        layer.cornerRadius = 15.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 14.0
        layer.shadowOpacity = 0.22
        layer.shadowOffset = CGSize(width: 0, height: 12)
        clipsToBounds = false
    }
    
    private func commonInit() {
        configureShadow()
        configureViews()
    }
    
    private func configureViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(gradientView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(averageRatingLabel)
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24.0).isActive = true
        
        gradientView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        
        averageRatingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12.0).isActive = true
        averageRatingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0).isActive = true
        averageRatingLabel.widthAnchor.constraint(equalToConstant: 52).isActive = true
    }
}
