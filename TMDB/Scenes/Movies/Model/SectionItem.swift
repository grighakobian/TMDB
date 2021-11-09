//
//  SectionItem.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 09.11.21.
//

import DifferenceKit

enum SectionItem {
    case state(LoadingState)
    case movie(MovieItemViewModel)
}


extension SectionItem {
    
    var movieViewModel: MovieItemViewModel? {
        switch self {
        case .movie(let viewModel):
            return viewModel
        default:
            return nil
        }
    }
}

extension SectionItem: Differentiable {
    
    public typealias DifferenceIdentifier = String
    
    public var differenceIdentifier: String {
        switch self {
        case .state(let loadingState):
            return loadingState.differenceIdentifier
        case .movie(let movie):
            return movie.differenceIdentifier
        }
    }
    
    func isContentEqual(to source: SectionItem) -> Bool {
        switch (self, source) {
        case (.state(let lhsState), .state(let rhsState)):
            return lhsState.isContentEqual(to: rhsState)
        case (.movie(let lhsMovie), .movie(let rhsMovie)):
            return lhsMovie.isContentEqual(to: rhsMovie)
        default:
            return false
        }
    }   
}
