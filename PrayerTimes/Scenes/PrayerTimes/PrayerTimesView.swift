//
//  PrayerTimesView.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit
import SnapKit

final class PrayerTimesView: UIView {
    
    var tabBarHeight: CGFloat? {
        didSet {
            stackView.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(-(tabBarHeight! + UIApplication.getSafeAreaBottom()))
            }
        }
    }
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg-1"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(named: "background")
        
        addSubviews(imageView, stackView)
        stackView.addArrangedSubviews(PrayerItemView(), PrayerItemView(), PrayerItemView(), PrayerItemView(), PrayerItemView())
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(snp.centerY).offset(-80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
