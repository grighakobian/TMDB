//
//  ViewModelsAssembly.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import Swinject
import Domain

public final class ViewModelsAssembly: Assembly {
    
    public func assemble(container: Container) {
        
        container.register(PopularSeriesViewModel.self) { resolver in
            let moviesService = resolver.resolve(Domain.MoviesService.self)!
            return PopularSeriesViewModel(moviesService: moviesService)
        }
    }
}

