//
//  AppDelegate.swift
//  Google Maps SDK for iOS
//
//  Created by Тауекел on 14.02.2024.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCD-WNTCQsDEf6cJM5pAsnUfV9R8ieM7t8")
        return true
    }
}

