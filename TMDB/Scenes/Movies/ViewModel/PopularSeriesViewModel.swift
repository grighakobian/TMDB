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

    private var currentPage: Int
    private var paginationContext: PaginationContext
    private let serialScheduler: SerialDispatchQueueScheduler
    private let sectionItems: BehaviorRelay<[MovieItemViewModel]>
    
    public init(moviesService: Domain.MoviesService) {
        self.moviesService = moviesService
        self.currentPage = 0
        self.paginationContext = PaginationContext()
        self.sectionItems = BehaviorRelay<[MovieItemViewModel]>(value: [])
        self.serialScheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    }
    
    public struct Input {
        /// Triggers when user scrolls to the
        /// bottom of the target scroll view
        let nextPageTrigger: Observable<Void>
        /// Triggers when user selects a movie
        let onMovieSelected: Observable<Int>
    }
    
    public struct Output {
        let popularMovies: Driver<[MovieItemViewModel]>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
    }
    
    public func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        input.nextPageTrigger
            .observe(on: serialScheduler)
            .skip(while: { [unowned self] in
                if !paginationContext.isFetching {
                    paginationContext.start()
                    return false
                }
                return true
            })
            .flatMap { [unowned self] _ -> Single<MoviesResult> in
                return moviesService.getPopularMovies(page: currentPage + 1)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asSingle()
            }
            .subscribe(onNext: { [unowned self] response in
                self.currentPage = response.page ?? 0
                let results = response.results ?? []
                let newSectionItems = results.map({ MovieItemViewModel(movie: $0) })
                var sectionItems = self.sectionItems.value
                sectionItems.append(contentsOf: newSectionItems)
                self.sectionItems.accept(sectionItems)
                self.paginationContext.finish(true)
            }, onError: { [unowned self] error in
                self.paginationContext.finish(false)
            }).disposed(by: disposeBag)
        
        input.onMovieSelected
            .withLatestFrom(sectionItems, resultSelector: { $1[$0] })
            .map({ AppStep.movieDetail($0) })
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output(popularMovies: sectionItems.asDriver(),
                      error: errorTracker.asDriver(),
                      isLoading: activityIndicator.asDriver())
    }
}
