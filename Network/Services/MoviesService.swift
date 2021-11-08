//
//  MoviesService.swift
//  Network
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import Domain
import RxSwift
import Moya

open class MoviesService: Domain.MoviesService {
    
    private let moyaProvider: MoyaProvider<API>
    
    public init(moyaProvider: MoyaProvider<API>) {
        self.moyaProvider = moyaProvider
    }
    
    public func getPopularTVShows(page: Int) -> Single<TVShowsResult> {
        return moyaProvider.rx.request(.popularTVShows)
            .map(TVShowsResult.self)
    }
}
