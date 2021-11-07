//
//  SceneDelegate.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 07.11.21.
//

import UIKit
import RxSwift
import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let appFlow = AppFlow()
        let stepper = OneStepper(withSingleStep: AppStep.popularSeries)
        let coordinator = FlowCoordinator()
        coordinator.coordinate(flow: appFlow, with: stepper)
        Flows.use(appFlow, when: .created) { [unowned self] viewController in
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
    }
}

