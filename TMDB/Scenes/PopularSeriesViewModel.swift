//
//  PopularSeriesViewModel.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import RxSwift
import RxRelay
import RxFlow
import Domain
import RxCocoa

public final class PopularSeriesViewModel: ViewModel, Stepper {
    
    public var steps = PublishRelay<Step>()
    
    private let moviesService: Domain.MoviesService
    
    public init(moviesService: Domain.MoviesService) {
        self.moviesService = moviesService
    }
    
    public struct Input {
        
    }
    
    public struct Output {
        let popularTVShows: Driver<[TVShow]>
    }
    
    public func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let popularTVShows = moviesService.getPopularTVShows(page: 1)
            .asDriver(onErrorDriveWith: Driver.empty())
            .map({ $0.results })
            .filter({ $0 == nil })
            .map({ $0! })
        
        return Output(popularTVShows: popularTVShows)
    }
}
