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
    
    public func getPopularMovies(page: Int) -> Single<MoviesResult> {
        return moyaProvider.rx.request(.popularMovies(page: page))
            .map(MoviesResult.self)
    }
}
