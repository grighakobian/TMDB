//
//  PopularSeriesViewModel.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import RxSwift
import RxRelay
import RxFlow

public final class PopularSeriesViewModel: ViewModel, Stepper {
    
    public var steps = PublishRelay<Step>()
    
    
    public struct Input {
        
    }
    
    public struct Output {
        
    }
    
    public func transform(input: Input, disposeBag: DisposeBag) -> Output {
        return Output()
    }
}
