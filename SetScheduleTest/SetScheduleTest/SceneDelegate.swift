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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window = self.window
    
    window = UIWindow(windowScene: scene)
    
    window?.makeKeyAndVisible()
    
    let initialVC = SearchViewController(SearchVCViewModelDefault(eventService: PredictHQEventService()))
    
    let nav = UINavigationController(rootViewController: initialVC)
    
    window?.rootViewController = nav
  }

}

