//
//  MoviesService.swift
//  Domain
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import RxSwift

public protocol MoviesService: AnyObject {
    /// Get a list of the current popular TV shows on TMDB.
    /// - Parameter page: Specify which page to query.
    ///                   Validation: minimum: 1, maximum: 1000, default: 1
    func getPopularTVShows(page: Int)->Single<TVShowsResult>
}
