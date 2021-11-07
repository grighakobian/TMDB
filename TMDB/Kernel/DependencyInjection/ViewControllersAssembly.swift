//
//  ViewControllersAssembly.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import Swinject

public final class ViewControllersAssembly: Assembly {
    
    public func assemble(container: Container) {
        
        container.register(PopularSeriesViewController.self) { resolvier in
            let viewModel = resolvier.resolve(PopularSeriesViewModel.self)!
            return PopularSeriesViewController(viewModel: viewModel)
        }
    }
}
