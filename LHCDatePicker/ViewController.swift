//
//  ViewController.swift
//  LHCDatepicker
//
//  Created by 每天农资 on 2018/5/14.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

class LHCDatepicker: UIView {
    
    enum 日期格式 {
        case 年月日
        case 年月
        case 年
    }
    
    var dateType: 日期格式 = .年月日
    
    private var 年份数组 = [Int]()
    private var 日数组 = [Int]()
    private let datepicker = UIPickerView()
    private let calendar = NSCalendar(identifier: .gregorian)
    private let dateformater = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        启动日历()
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func 启动日历() {
        
        let yearStr = 返回当前日期字符串(dateFormate: "yyyy")
        if let year = Int(yearStr) {
            for item in 1970...year {
                年份数组.append(item)
            }
        }
        
        let day = 获取一个月的所有天(月: Date())
        for item in 1...day {
            日数组.append(item)
        }
        
    }
    
    private func setupUI() {
        
        datepicker.dataSource = self
        datepicker.delegate = self
        
        addSubview(datepicker)
    }
    
    
    private func 获取一个月的所有天( 月: Date) -> Int {
        let calendar = NSCalendar.current
        let month = calendar.range(of: .day, in: .month, for: 月)
        if let month = month {
            return month.upperBound - 1
        }else {
            return 0
        }
    }
    
    func 返回当前日期字符串(dateFormate: String = "yyyy-MM-dd") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormate
        return formate.string(from: Date())
    }
    
    func 返回一个月前日期字符串(dateFormate: String = "yyyy-MM-dd") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormate
        
        let lastMonth = Date(timeIntervalSinceNow: -30 * 24 * 60 * 60)
        return formate.string(from: lastMonth)
        
    }
    
    func 返回七天前日期字符串(dateFormate: String = "yyyy-MM-dd") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormate
        
        let lastMonth = Date(timeIntervalSinceNow: -7 * 24 * 60 * 60)
        return formate.string(from: lastMonth)
    }
}

extension LHCDatepicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch dateType {
        case .年:
            return 1
        case .年月:
            return 2
        case .年月日:
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch dateType {
        case .年:
            
            return 年份数组.count
            
        case .年月:
            if component == 0 {
                
                return 年份数组.count
            }else {
                return 12
            }
        case .年月日:
            if component == 0 {
                return 年份数组.count
            }else if component == 1 {
                return 12
            }else {
                return 日数组.count
            }
        }
    }

}
