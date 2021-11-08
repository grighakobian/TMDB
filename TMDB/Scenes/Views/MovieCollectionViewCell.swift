//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import UIKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 15.0
        containerView.clipsToBounds = true
        containerView.backgroundColor = .secondarySystemFill
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor.quaternarySystemFill.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.textColor = UIColor.label
        return titleLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
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
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
