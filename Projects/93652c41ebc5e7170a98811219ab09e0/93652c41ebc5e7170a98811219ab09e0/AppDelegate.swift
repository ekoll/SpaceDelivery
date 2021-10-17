//
//  AppDelegate.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import UIKit
import Domain

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = LoadingView(viewModel: .init(useCase: StationLoader(repository: ApiStationRepository(), favouriteRepository: InMemoryFavoriteStationRepository()), router: LoadingViewRouter()))
        
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        return true
    }
}
