//
//  SceneDelegate.swift
//  Google Maps SDK for iOS
//
//  Created by Тауекел on 14.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(
            rootViewController: OnTheMapViewController()
        )
        window?.makeKeyAndVisible()
    }
}

