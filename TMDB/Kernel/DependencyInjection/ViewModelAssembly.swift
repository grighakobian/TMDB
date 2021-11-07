//
//  ViewModelAssembly.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import Swinject

public final class ViewModelAssembly: Assembly {
    
    public func assemble(container: Container) {
        
        container.register(PopularSeriesViewModel.self) { resolvier in
            return PopularSeriesViewModel()
        }
    }
}

