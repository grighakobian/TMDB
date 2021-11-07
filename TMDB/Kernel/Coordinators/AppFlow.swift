//
//  AppFlow.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import RxFlow
import UIKit

public final class AppFlow {
    
    private let navigationController: UINavigationController
    
    public init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
}

extension AppFlow: Flow {
    
    public var root: Presentable {
        return navigationController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else { return .none }
        switch appStep {
        case .popularSeries:
            let resolver = Dependency.shared.resolver
            let viewController = resolver.resolve(PopularSeriesViewController.self)!
            navigationController.pushViewController(viewController, animated: true)
            return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
        }
    }
}
