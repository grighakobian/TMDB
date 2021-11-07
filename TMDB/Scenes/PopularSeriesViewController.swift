//
//  PopularSeriesViewController.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import UIKit

public final class PopularSeriesViewController: UIViewController {
    
    private let viewModel: PopularSeriesViewModel
    
    init(viewModel: PopularSeriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    
}
