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
        
        container.register(MovieDetailViewController.self) { (resolver: Resolver, movie: MovieRepresentable) in
            let viewModel = resolver.resolve(MovieDetailViewModel.self, argument: movie)!
            return MovieDetailViewController(viewModel: viewModel)
        }
    }
}
