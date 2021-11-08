//
//  ViewControllersAssembly.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import Domain
import Swinject

public final class ViewControllersAssembly: Assembly {
    
    public func assemble(container: Container) {
        
        container.register(PopularSeriesViewController.self) { resolver in
            let viewModel = resolver.resolve(PopularSeriesViewModel.self)!
            return PopularSeriesViewController(viewModel: viewModel)
        }
        
        container.register(MovieDetailViewController.self) { (resolver: Resolver, tvShow: TVShow) in
            let viewModel = resolver.resolve(MovieDetailViewModel.self, argument: tvShow)!
            return MovieDetailViewController(viewModel: viewModel)
        }
    }
}
