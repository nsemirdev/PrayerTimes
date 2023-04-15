//
//  SceneDelegate.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        showAlert()
    }

    
    func sceneDidEnterBackground(_ scene: UIScene) {
        showAlert()
        let tabBar = (window!.rootViewController) as! TabBarController
        let mainVC = tabBar.viewControllers![0] as! PrayerTimesController
        mainVC.containerView?.viewModel.delegate?.invalidateTimer()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        let tabBar = (window!.rootViewController) as! TabBarController
        let mainVC = tabBar.viewControllers![0] as! PrayerTimesController
        if let prayerTimes = mainVC.prayerTimes {
            mainVC.containerView?.viewModel.didReceivePrayerTimes(prayerTimes: prayerTimes)
        }
    }

    private func showAlert() {
        if let timeName = UserDefaults.standard.string(forKey: "timeName") {
            let remainTime = UserDefaults.standard.integer(forKey: "remainTime")
            let content = UNMutableNotificationContent()
            content.title = "\(timeName) namazı yaklaşıyor!"
            content.body = "10 dakika sonra \(timeName) ezanı okunacak."
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(remainTime - 600), repeats: false)
            let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
}

