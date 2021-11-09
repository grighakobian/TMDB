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
    let averageRating: Double?
    let overview: String?
    
    init(tvShow: TVShow) {
        self.id = tvShow.id ?? 0
        self.title = tvShow.name ?? ""
        self.averageRating = tvShow.voteAverage
        self.overview = tvShow.overview
        
        if let posterPath = tvShow.posterPath {
            let posterPath = "https://image.tmdb.org/t/p/w500/\(posterPath)"
            self.posterImageUrl = URL(string: posterPath)!
        } else {
            self.posterImageUrl = nil
        }
    }
}

// MARK: - Equatable

extension MovieItemViewModel: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.posterImageUrl == rhs.posterImageUrl &&
            lhs.averageRating == rhs.averageRating
    }
}

// MARK: - Hashable

extension MovieItemViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: - Differentiable

extension MovieItemViewModel: Differentiable {}
