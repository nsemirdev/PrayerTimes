//
//  PrayerTimesController.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit
import NetworkManager
import CoreLocation

final class PrayerTimesController: UIViewController {
    
    var containerView: PrayerTimesView? {
        guard isViewLoaded else { return nil }
        return view as? PrayerTimesView
    }
    
    var prayerTimes: PrayerTimes? {
        didSet {
            containerView?.viewModel.didReceivePrayerTimes(prayerTimes: prayerTimes!)
        }
    }
    
    private let locationManager = CLLocationManager()
    
    override func loadView() {
        super.loadView()
        view = PrayerTimesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("we have permission")
            } else {
                print("permission denied")
            }
        }
        
        containerView?.delegate = self
        containerView?.tabBarHeight = tabBarController?.tabBar.frame.height
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        containerView?.viewModel.didReceivePrayerTimes(prayerTimes: <#T##PrayerTimes#>)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView?.updateGradientWith(frame: containerView!.getFrame)
    }
    
    var gotLocation = false
}

extension PrayerTimesController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
    
        if !gotLocation {
            let lon = locations.last!.coordinate.longitude
            let lat = locations.last!.coordinate.latitude
            
            NetworkManager.shared.task(lat: lat, lon: lon) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.prayerTimes = success

                    }
                case .failure(let failure):
                    DispatchQueue.main.async {
                        self.containerView?.viewModel.didReceiveError(error: failure)
                    }
                }
            }
            gotLocation = true
        }
    }
}

extension PrayerTimesController: PrayerTimesViewDelegate {
    func updateTime(_ view: PrayerTimesView) {
        if let prayerTimes {
            view.viewModel.didReceivePrayerTimes(prayerTimes: prayerTimes)
        }
    }
}
