//
//  MoviesDetailViewModel.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//


import Domain
import RxSwift
import RxCocoa

public class MoviesDetailViewModel: ViewModel {
    
    
    private let tvShow: TVShow
    
    public init(tvShow: TVShow) {
        self.tvShow = tvShow
    }
    
    public struct Input {
        
    }
    
    public struct Output {
        let tvShowDriver: Driver<TVShow>
    }
    
    public func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let tvShowDriver = Driver.just(tvShow)
        return Output(tvShowDriver: tvShowDriver)
    }
}
