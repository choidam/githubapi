//
//  AppDelegate.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//
@_exported import Foundation
@_exported import UIKit

@_exported import RxSwift
@_exported import ReactorKit
@_exported import RxDataSources
@_exported import Reusable
@_exported import Moya
@_exported import RxMoya
@_exported import SnapKit
@_exported import Then

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)        
        let viewController = ListViewController.create() ?? UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
}
