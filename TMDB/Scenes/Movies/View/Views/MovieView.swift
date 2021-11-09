//
//  MovieView.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 09.11.21.
//

import UIKit

final class MovieView: UIView {
    
    lazy var titleLabel = makeTitleLabel()
    lazy var imageView = makeImageView()
    lazy var ratingLabel = makeRatingLabel()
    lazy var gradientView = makeGradientView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func bind(item: MovieRepresentable) {
        titleLabel.text = item.title
        imageView.sd_setImage(with: item.posterImageUrl, completed: nil)
        if let averageRating = item.averageRating {
            ratingLabel.text = String(averageRating)
        } else {
            ratingLabel.text = nil
        }
    }
    
    func prepareForReuse() {
        imageView.image = nil
        imageView.sd_cancelCurrentImageLoad()
    }
    
    private func commonInit() {
        backgroundColor = .secondarySystemFill
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.quaternarySystemFill.cgColor
        
        addSubviews()
        configureImageView()
        configureTitleLabel()
        configureGradientView()
        configureRatingLabel()
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(gradientView)
        addSubview(titleLabel)
        addSubview(ratingLabel)
    }
    
    private func configureImageView() {
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func configureGradientView() {
        gradientView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
    }
    
    private func configureTitleLabel() {
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0).isActive = true
    }
    
    private func configureRatingLabel() {
        ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 52).isActive = true
    }
}


extension MovieView {
    
    private func makeTitleLabel()->UILabel {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 46, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
    
    private func makeRatingLabel()-> InsetLabel {
        let titleLabel = InsetLabel()
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = UIColor.systemPink
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.layer.cornerRadius = 4.0
        titleLabel.clipsToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.textInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
    
    private func makeImageView()-> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.sd_imageTransition = .fade(duration: 0.2)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func makeGradientView()-> GradientView {
        let gradientView = GradientView()
        gradientView.gradientDirection = .vertical
        let startColor = UIColor.black.withAlphaComponent(0.75)
        let endColor = UIColor.black.withAlphaComponent(0.0)
        gradientView.colors = [endColor, startColor]
        gradientView.clipsToBounds = true
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }
}
