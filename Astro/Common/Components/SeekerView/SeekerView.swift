//
//  SeekerView.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SeekerView: UIView {

    typealias SeekerTimeChangedHandler = (SeekerView, String, Int, Int)->Void
    
    fileprivate var scrollView = UIScrollView()
    fileprivate let times = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00PM", "20:00", "21:00", "22:00", "23:00", "00:00"]
    fileprivate var timeViews = [SeekerTimeView]()
    fileprivate var nowLabel = UILabel()
    fileprivate var seekerView = UIView()
    fileprivate var seekButton = UIButton()
    
    var seekerTimeChanged: SeekerTimeChangedHandler?
    var currentTime = SeekTime()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        scrollView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        }
        scrollView.contentSize = CGSize(width: 60 * 24 + (frame.size.width), height: scrollView.frame.size.height)
        
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        
        nowLabel.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(70)
        }
        seekButton.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        
        seekerView.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(2)
        }
        
        var index = 0
        for time in timeViews {
            let f = time.frame
            
            time.frame = CGRect(x: CGFloat(index) * 60 + (frame.size.width * 0.5), y: f.origin.y, width: f.size.width, height: scrollView.frame.size.height)
            index += 1
        }
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.lightGray
        self.addSubview(scrollView)
        self.addSubview(nowLabel)
        self.addSubview(seekerView)
        self.addSubview(seekButton)
        
        scrollView.backgroundColor = UIColor.darkGray
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.delegate = self
        for time in times {
            let time1 = SeekerTimeView(frame: CGRect.zero)
            time1.timeLabel.text = time
            time1.timeLabel.textAlignment = .center 
            scrollView.addSubview(time1)
            timeViews += [time1]
        }
        
        seekButton.backgroundColor = UIColor(hex: "#04a9f3")
        seekButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        seekButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        seekButton.setTitle("00:00", for: .normal)
        
        seekButton.rx.tap.bind {
            let time = self.currentTime.hour >= 24 ? "00:00" : String(format: "%02d:%02d", arguments: [self.currentTime.hour, self.currentTime.minute])
            self.seekerTimeChanged?(self, time, self.currentTime.hour, self.currentTime.minute)
        }.disposed(by: disposeBag)
        
        seekerView.backgroundColor = UIColor(hex: "#04a9f3")
        
        let (hour, minute) = DateUtils.currentTime()
        seekTime(hour: hour, minute: minute)
    }
    
    func seekTime(hour: Int, minute: Int) {
        let posX = (hour  + (minute / 60)) * 120
        scrollView.setContentOffset(CGPoint(x: posX, y: 0), animated: true)
    }
}

extension SeekerView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let posX = min(max(scrollView.contentOffset.x, 0), 60 * 24)
        let hourComma = posX / 60
        let minutesFrac = hourComma.truncatingRemainder(dividingBy: 1)
        let minutes = Int(min(round(minutesFrac * 60), 59))
        let hour = Int(floor(hourComma))
        let time = hour >= 24 ? "00:00" : String(format: "%02d:%02d", arguments: [hour, minutes])
        
        nowLabel.text = time
        seekButton.setTitle("Go to \(time)", for: .normal)
        currentTime.hour = hour
        currentTime.minute = minutes
        
        //seekerTimeChanged?(self, time, hour, minutes)
    }
    
}
