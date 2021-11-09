//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//


import Domain
import RxSwift
import RxCocoa
import RxFlow

public class MovieDetailViewModel: ViewModel, Stepper {

    public var steps = PublishRelay<Step>()
    
    private let movie: MovieRepresentable
    private let moviesSevice: Domain.MoviesService
    
    public init(movie: MovieRepresentable,
                moviesSevice: Domain.MoviesService) {
        
        self.movie = movie
        self.moviesSevice = moviesSevice
    }
    
    public struct Input {
        
    }
    
    public struct Output {
        let movieDriver: Driver<MovieRepresentable>
    }
    
    public func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let movieDriver = Driver.just(movie)
        return Output(movieDriver: movieDriver)
    }
}
