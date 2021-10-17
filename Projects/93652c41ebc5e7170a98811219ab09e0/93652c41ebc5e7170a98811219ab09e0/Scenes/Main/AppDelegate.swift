//
//  AppDelegate.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import UIKit
import Domain
import Presentation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let container = baseContainer
        let view: LoadingView = container.resolve()
        
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        return true
    }
    
    var baseContainer: DependencyContainer {
        let container = DependencyContainer()
        container.append(type: FavoriteStationRepository.self) { _ in InMemoryFavoriteStationRepository() }
        container.append(type: StationRepository.self) { _ in ApiStationRepository() }
        container.append(type: AppLoadRouter.self) { cont in LoadingViewRouter(container: cont) }
        container.append(type: LoadStationUseCase.self) { cont in
            StationLoader(repository: cont.resolve(), favouriteRepository: cont.resolve())
        }
        container.append(type: AppLoadViewModel.self) { cont in .init(useCase: cont.resolve(), router: cont.resolve()) }
        container.append(type: LoadingView.self, generator: { cont in .init(viewModel: cont.resolve()) })
        
        return container
    }
}
