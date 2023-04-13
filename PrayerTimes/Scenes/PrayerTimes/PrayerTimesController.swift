//
//  PrayerTimesController.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit

final class PrayerTimesController: UIViewController {
    
    private var containerView: PrayerTimesView? {
        guard isViewLoaded else { return nil }
        return view as? PrayerTimesView
    }
    
    override func loadView() {
        super.loadView()
        view = PrayerTimesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView?.tabBarHeight = tabBarController?.tabBar.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
