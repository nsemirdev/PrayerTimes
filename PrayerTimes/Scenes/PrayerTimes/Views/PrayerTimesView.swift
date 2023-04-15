//
//  PrayerTimesView.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit
import SnapKit

final class PrayerTimesView: UIView {
    
    var timer: Timer!
    var getFrame: CGRect {
        dateArea.frame
    }
    
    weak var delegate: PrayerTimesViewDelegate?
    
    var tabBarHeight: CGFloat? {
        didSet {
            stackView.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(-(tabBarHeight! + UIApplication.getSafeAreaBottom()))
            }
        }
    }
    
    var viewModel = PrayerTimesViewModel()
    
    private let imageView = UIImageView(imageName: "bg-2", contenMode: .scaleAspectFill)
    private let cityLabel = UILabel(font: .ceraMedium(size: 17), textColor: .white)
    private let dateArea = UIView()
    private let dateLabel = UILabel(font: .ceraBold(size: 20), textColor: .white)
    private let timeNameLabel = UILabel(font: .ceraMedium(size: 20), textColor: .white)
    private let remainTimeLabel = UILabel(font: .ceraLight(size: 96), textColor: .white)
    private let remainSecondLabel = UILabel(font: .ceraMedium(size: 32), textColor: .white)
    
    private lazy var remainStack = UIStackView(axis: .horizontal, spacing: 2, distribution: .fill, arrangedSubviews: [
        remainTimeLabel, remainSecondLabel
    ])
    private lazy var labelsStack = UIStackView(axis: .vertical, spacing: 5, distribution: .fill, arrangedSubviews: [
        timeNameLabel, remainStack
    ])
    
    private let stackView = UIStackView(axis: .vertical, spacing: 2, distribution: .fillEqually ,arrangedSubviews: [
        SingleTimeView(label: "İmsak", time: "--:--", image: "imsak"),
        SingleTimeView(label: "Güneş", time: "--:--", image: "gunes"),
        SingleTimeView(label: "Öğle", time: "--:--", image: "ogle"),
        SingleTimeView(label: "İkindi", time: "--:--", image: "ikindi"),
        SingleTimeView(label: "Akşam", time: "--:--", image: "aksam"),
        SingleTimeView(label: "Yatsı", time: "--:--", image: "yatsi")
    ])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.delegate = self
        setupViews()
        initViews()
    }
    
    private func initViews() {
        cityLabel.text = "----, ----"
        dateLabel.text = "-- --- ----, ------"
        timeNameLabel.text = "----- vaktine kalan süre"
        remainTimeLabel.text = "--:--"
        remainSecondLabel.text = "--"
    }
    
    private func setupViews() {
        backgroundColor = .init(named: "background")
        addSubviews(imageView, stackView, cityLabel, dateArea, labelsStack)
        dateArea.addSubview(dateLabel)
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(snp.centerY).offset(-70)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(UIApplication.getSafeAreaTop() + 10)
        }
        
        dateLabel.textAlignment = .center
        dateArea.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        labelsStack.snp.makeConstraints { make in
            make.center.equalTo(imageView.snp.center)
        }
        
        remainStack.alignment = .top
    }
    
    func updateGradientWith(frame: CGRect) {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height)
        
        dateArea.layer.addSublayer(gradientLayer)
        dateArea.bringSubviewToFront(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentlyActiveView: SingleTimeView?
}

extension PrayerTimesView: PrayerTimesViewModelDelegate {
    func updateView(with item: PrayerTimesPresentation) {
        for (idx, view) in stackView.subviews.enumerated() {
            let singleTimeView = (view as! SingleTimeView)
            singleTimeView.updateLabel(with: item.times[idx])
            
            if idx == item.nowItemIdx {
                imageView.image = UIImage(named: "bg-\(idx)")
                singleTimeView.makeCurrentTime()
                if idx != 5 {
                    let view = (stackView.subviews[idx + 1] as! SingleTimeView)
                    currentlyActiveView = view
                    let attrText = NSMutableAttributedString(string: view.getCurrentTimeName, attributes: [.font: UIFont.ceraBold(size: 20)])
                    attrText.append(NSAttributedString(string: " vaktine kalan süre", attributes: [.font: UIFont.ceraMedium(size: 20)]))
                    timeNameLabel.attributedText = attrText
                } else {
                    let view = (stackView.subviews[0] as! SingleTimeView)
                    currentlyActiveView = view
                    let attrText = NSMutableAttributedString(string: view.getCurrentTimeName, attributes: [.font: UIFont.ceraBold(size: 20)])
                    attrText.append(NSAttributedString(string: " vaktine kalan süre", attributes: [.font: UIFont.ceraMedium(size: 20)]))
                    timeNameLabel.attributedText = attrText
                }
            } else {
                singleTimeView.clearCurrentTime()
            }
        }
        
        cityLabel.text = item.placeName
        dateLabel.text = item.date
        var remainTime = item.remainTime
        remainTimeLabel.text = remainTime.hourMinuteFromTimeInterval()
        remainSecondLabel.text = remainTime.secondFromTimeInterval()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            
            if remainTime <= 0 {
                delegate?.updateTime(self)
                timer.invalidate()
            }
            UserDefaults.standard.set(currentlyActiveView?.getCurrentTimeName, forKey: "timeName")
            UserDefaults.standard.set(remainTime, forKey: "remainTime")
            remainTime -= 1
            self.remainTimeLabel.text = remainTime.hourMinuteFromTimeInterval()
            self.remainSecondLabel.text = remainTime.secondFromTimeInterval()
        })
    }
    
    func invalidateTimer() {
        if timer.isValid {
            print("invalidated")
            timer.invalidate()
        }
    }
    
    func updateViewWithError() {
        print("error")
    }
}
