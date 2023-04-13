//
//  PrayerItemView.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit

final class PrayerItemView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
        
        let lbl1 = UILabel()
        lbl1.text = "Test1"
        
        let lbl2 = UILabel()
        lbl2.text = "Test2"
        
        let v = UIView()
        
        let lbl3 = UILabel()
        lbl3.text = "Test3"
        
        stackView.addArrangedSubview(lbl1)
        stackView.addArrangedSubview(lbl2)
        stackView.addArrangedSubview(v)
        stackView.addArrangedSubview(lbl3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
