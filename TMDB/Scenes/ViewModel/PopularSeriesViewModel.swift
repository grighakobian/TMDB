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
        let nextPageTrigger: Observable<Void>
    }
    
    public struct Output {
        let popularTVShows: Driver<[MovieItemViewModel]>
    }
    
    public func transform(input: Input, disposeBag: DisposeBag) -> Output {
        input.nextPageTrigger
            .observe(on: serialScheduler)
            .skip(while: { [unowned self] in
                if !paginationContext.isFetching {
                    paginationContext.start()
                    return false
                }
                return true
            })
            .flatMap { [unowned self] _ -> Single<TVShowsResult> in
                return moviesService.getPopularTVShows(page: currentPage + 1)
            }
            .subscribe(onNext: { [unowned self] response in
                self.currentPage = response.page ?? 0
                let results = response.results ?? []
                let newSectionItems = results.map({ MovieItemViewModel(tvShow: $0) })
                var sectionItems = self.sectionItems.value
                sectionItems.append(contentsOf: newSectionItems)
                self.sectionItems.accept(sectionItems)
                self.paginationContext.finish(true)
            }, onError: { [unowned self] error in
                self.paginationContext.finish(false)
            }).disposed(by: disposeBag)
        
        return Output(popularTVShows: sectionItems.asDriver())
    }
}
