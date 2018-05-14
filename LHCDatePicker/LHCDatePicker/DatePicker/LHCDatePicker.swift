//
//  LHCDatePicker.swift
//  LHCDatePicker
//
//  Created by 每天农资 on 2018/5/14.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

protocol LHCDatePickerDelegate: class {
    func 点击确定(date: String)
    func 点击取消(date: String)
}

class LHCDatepicker: UIView {
    
    enum 日期格式 {
        case 年月日
        case 年月
        case 年
    }
    
    
    private let shadow = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    private let 确定按钮 = UIButton(frame: CGRect(x: screenWidth - 55, y: screenHeight - 260, width: 55, height: 45))
    
    var dateType: 日期格式 = .年月日
    
    private let 月份数组 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private var 年份数组 = [Int]()
    private var 日数组 = [Int]()
    private let datepicker = UIPickerView()
    private let calendar = NSCalendar(identifier: .gregorian)
    private let dateformater = DateFormatter()
    
    var maxDate: Date?
    var minDate: Date?
    
    private var 选中年 = ""
    private var 选中月 = ""
    private var 选中日 = ""
    
    weak var delegate: LHCDatePickerDelegate?
    
    init(frame: CGRect, 起始时间: String = "1970-01-01") {
        super.init(frame: frame)
        
        启动日历(起始时间: 起始时间)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func 启动日历(起始时间: String) {
        
        let yearStr = 返回某个年份(年月日: 起始时间)
        
        for item in (yearStr.1)...(返回当前年份().1) {
            年份数组.append(item)
        }
        
        let day = 获取一个月的所有天(月: Date())
        for item in 1...day {
            日数组.append(item)
        }
        
        guard dateType == .年月日 else {return}
        minDate = 返回某日Date(年月日: 起始时间)
        maxDate = Date()
        
        if let 最晚日期 = maxDate {
            
        }
        
        
    }
    
    private func setupUI() {
        
        shadow.backgroundColor = UIColor(hexColor: "000000")
        shadow.alpha = 0.2
        shadow.addTarget(self, action: #selector(点击取消), for: .touchUpInside)
        addSubview(shadow)
        
        let whiteLine = UIView(frame: CGRect(x: 0, y: screenHeight - 260, width: screenWidth, height: 45))
        whiteLine.backgroundColor = UIColor.white
        addSubview(whiteLine)
        
        确定按钮.setTitle("确定", for: .normal)
        确定按钮.backgroundColor = UIColor.white
        确定按钮.setTitleColor(UIColor(hexColor: "1A1917"), for: .normal)
        确定按钮.addTarget(self, action: #selector(点击确定), for: .touchUpInside)
        addSubview(确定按钮)
        
        datepicker.backgroundColor = UIColor.white
        datepicker.dataSource = self
        datepicker.delegate = self
        
        let frame = CGRect(x: 0, y: screenHeight - 215, width: screenWidth, height: 215)
        datepicker.frame = frame
        
        datepicker.selectRow(年份数组.count - 1, inComponent: 0, animated: true)
        
        switch dateType {
        case .年月:
            datepicker.selectRow(返回当前月份().1 - 1, inComponent: 1, animated: true)
        case .年月日:
            datepicker.selectRow(返回当前月份().1 - 1, inComponent: 1, animated: true)
            datepicker.selectRow(返回当前日期().1 - 1, inComponent: 2, animated: true)
        default:
            print("")
        }
        
        addSubview(datepicker)
        
        let grayLine = UIView(frame: CGRect(x: 0, y: screenHeight - 215, width: screenWidth, height: 1))
        grayLine.backgroundColor = UIColor(hexColor: "CCCCCC")
        addSubview(grayLine)
    }
    
    @objc private func 点击取消() {
        print("点击取消")
        if let delegate = delegate {
            switch dateType {
            case .年:
                delegate.点击取消(date: 选中年)
            case .年月:
                delegate.点击取消(date: "\(选中年)-\(选中月)")
            case .年月日:
                delegate.点击取消(date: "\(选中年)-\(选中月)-\(选中日)")
            }
            
        }
    }
    
    @objc private func 点击确定() {
        print("点击确定")
        if let delegate = delegate {
            switch dateType {
            case .年:
                delegate.点击取消(date: 选中年)
            case .年月:
                delegate.点击取消(date: "\(选中年)-\(选中月)")
            case .年月日:
                delegate.点击取消(date: "\(选中年)-\(选中月)-\(选中日)")
            }
            
        }
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
    
    private func 返回当前日期字符串(dateFormate: String = "yyyy-MM-dd") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormate
        return formate.string(from: Date())
    }
    
    private func 返回一个月前日期字符串(dateFormate: String = "yyyy-MM-dd") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormate
        
        let lastMonth = Date(timeIntervalSinceNow: -30 * 24 * 60 * 60)
        return formate.string(from: lastMonth)
        
    }
    
    private func 返回七天前日期字符串(dateFormate: String = "yyyy-MM-dd") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormate
        
        let lastMonth = Date(timeIntervalSinceNow: -7 * 24 * 60 * 60)
        return formate.string(from: lastMonth)
    }
    
    private func 返回当前日期() -> (String, Int) {
        let formate = DateFormatter()
        formate.dateFormat = "d"
        
        let day = formate.string(from: Date())
        return (day, Int(day)!)
    }
    
    private func 返回当前月份() -> (String, Int) {
        let formate = DateFormatter()
        formate.dateFormat = "M"
        
        let day = formate.string(from: Date())
        return (day, Int(day)!)
    }
    
    private func 返回当前年份() -> (String, Int) {
        let formate = DateFormatter()
        formate.dateFormat = "yyyy"
        
        let day = formate.string(from: Date())
        return (day, Int(day)!)
    }
    
    private func 返回某个年份(年月日: String) -> (String, Int) {
        
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM-dd"
        if let date = formate.date(from: 年月日) {
            formate.dateFormat = "yyyy"
            let day = formate.string(from: date)
            return (day, Int(day)!)
        }else {
            return ("1970", 1970)
        }
    }
    
    private func 返回某日Date(年月日: String) -> Date? {
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM-dd"
        return formate.date(from: 年月日)
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var str = ""
        switch dateType {
        case .年:
            str = "\(年份数组[row])年"
        case .年月:
            if component == 0 {
                str = "\(年份数组[row])年"
            }else {
                str = "\(月份数组[row])月"
            }
        case .年月日:
            if component == 0 {
                str = "\(年份数组[row])年"
            }else if component == 1 {
                str = "\(月份数组[row])月"
            }else {
                str = "\(日数组[row])日"
            }
        }
        
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: UIColor(hexColor: "1A1917")])
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 { //滑动月份
            
            let month = 月份数组[row]
            
            let dateFormate = DateFormatter()
            dateFormate.dateFormat = "yyyy-M"
            
            let date = dateFormate.date(from: "2018-\(month)")
            
            let upper = 获取一个月的所有天(月: date!)
            
            日数组.removeAll()
            for item in 1...upper {
                日数组.append(item)
            }
            
            if dateType == .年月日 {
                pickerView.reloadComponent(2)
            }
            
        }else if component == 0 { //滑动年份
            
            
        }
        
        //返回值
        if component == 0 {
            选中年 = "\(年份数组[row])"
        }else if component == 1 {
            选中月 = "\(月份数组[row])"
        }else {
            选中日 = "\(日数组[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
}
