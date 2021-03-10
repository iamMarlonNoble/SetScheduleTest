//
//  SceneDelegate.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: scene)
    
    window?.makeKeyAndVisible()
    
    let initialVC = SearchViewController(SearchControllerViewModelMock())
    
    let nav = UINavigationController(rootViewController: initialVC)
    
    window?.rootViewController = nav
  }

}

