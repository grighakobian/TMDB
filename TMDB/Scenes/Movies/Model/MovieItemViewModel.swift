//
//  MovieItemViewModel.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import Domain
import DifferenceKit

struct MovieItemViewModel: MovieRepresentable {
    
    let id: Int
    let title: String?
    let posterImageUrl: URL?
    let averageRating: String?
    let overview: String?
    
    init(movie: Movie) {
        self.id = movie.id ?? 0
        self.title = movie.name ?? ""
        self.overview = movie.overview
        
        if let voteAverage = movie.voteAverage {
            self.averageRating = String(format: "%.1f", voteAverage)
        } else {
            self.averageRating = nil
        }
        
        if let posterPath = movie.posterPath {
            let posterPath = "https://image.tmdb.org/t/p/w500/\(posterPath)"
            self.posterImageUrl = URL(string: posterPath)!
        } else {
            self.posterImageUrl = nil
        }
    }
}

// MARK: - Equatable

extension MovieItemViewModel: Differentiable {
    
    typealias DifferenceIdentifier = String
    
    var differenceIdentifier: String {
        return id.description
    }
    
    func isContentEqual(to source: MovieItemViewModel) -> Bool {
        return self.id == source.id &&
            self.title == source.title &&
            self.posterImageUrl == source.posterImageUrl &&
            self.averageRating == source.averageRating
    }
}
