//
//  SceneDelegate.swift
//  CurrenciesApp
//
//  Created by Fernando Pena on 25/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        self.window = UIWindow(windowScene: windowScene)
        setupWindow()
    }

    private func setupWindow() {
        window?.rootViewController = CurrenciesViewController(repository: CoindeskApiClientAdapter())
        window?.makeKeyAndVisible()
    }
}
