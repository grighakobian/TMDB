//
//  ViewModelsAssembly.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import Domain
import Swinject

public final class ViewModelsAssembly: Assembly {
    
    public func assemble(container: Container) {
        
        container.register(PopularSeriesViewModel.self) { resolver in
            let moviesService = resolver.resolve(Domain.MoviesService.self)!
            return PopularSeriesViewModel(moviesService: moviesService)
        }

        container.register(MoviesDetailViewModel.self) { (resolver: Resolver, tvShow: TVShow) in
            return MoviesDetailViewModel(tvShow: tvShow)
        }
    }
}

