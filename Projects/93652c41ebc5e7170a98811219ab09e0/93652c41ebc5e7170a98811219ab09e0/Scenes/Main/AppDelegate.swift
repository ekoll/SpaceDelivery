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
        
        window?.rootViewController = mainView
        window?.makeKeyAndVisible()
        return true
    }
    
    var mainView: UIViewController {
        let container = baseContainer
        let viewModel = AppLoadViewModel(useCase: container.resolve(), router: container.resolve())
        let view: LoadingView = .init(viewModel: viewModel)
        
        viewModel.view = view
        
        return view
    }
    
    var baseContainer: DependencyContainer {
        let container = DependencyContainer()
        container.append(type: FavoriteStationRepository.self) { _ in InMemoryFavoriteStationRepository() }
        container.append(type: StationRepository.self) { _ in ApiStationRepository() }
        container.append(type: AppLoadRouter.self) { cont in LoadingViewRouter(container: cont) }
        container.append(type: LoadStationUseCase.self) { cont in
            StationLoader(repository: cont.resolve(), favouriteRepository: cont.resolve())
        }
        
        return container
    }
}
