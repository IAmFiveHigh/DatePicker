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
    
    private var 月份数组 = [Int]()
    private var 年份数组 = [Int]()
    private var 日数组 = [Int]()
    private let datepicker = UIPickerView()
    
    var maxDate: Date? {
        didSet {
            设置最晚(date: maxDate!)
            选中年 = 返回当前年份().0
            选中月 = 返回当前月份().0
            
            生成月数组()
            生成日数组()
            datepicker.reloadAllComponents()
            
            
        }
    }
    var minDate: Date? {
        didSet {
            设置最早(date: minDate!)
            选中年 = 返回当前年份().0
            选中月 = 返回当前月份().0
            
            生成月数组()
            生成日数组()
            datepicker.reloadAllComponents()
            
            
        }
    }
    
    private var 最早年月日: (年: Int, 月: Int, 日: Int) = (0,0,0)
    private var 最晚年月日: (年: Int, 月: Int, 日: Int) = (0,0,0)
    
    
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
        
        
        设置最早(date: 返回某日Date(年月日: 起始时间)!)
        
        
        设置最晚(date: Date())
        
        选中年 = 返回当前年份().0
        选中月 = 返回当前月份().0
        
        生成月数组()
        生成日数组()
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
            if 返回当前年份().1 == 最早年月日.年 {
                datepicker.selectRow(返回当前月份().1 - 最早年月日.年, inComponent: 1, animated: true)
            }else {
                datepicker.selectRow(返回当前月份().1 - 1, inComponent: 1, animated: true)
            }
            
        case .年月日:
            if 返回当前年份().1 == 最早年月日.年 {
                datepicker.selectRow(返回当前月份().1 - 最早年月日.月, inComponent: 1, animated: true)
            }else {
                datepicker.selectRow(返回当前月份().1 - 1, inComponent: 1, animated: true)
            }
            
            if 返回当前月份().1 == 最早年月日.月 {
                datepicker.selectRow(返回当前日期().1 - 最早年月日.日, inComponent: 2, animated: true)
            }else {
                datepicker.selectRow(返回当前日期().1 - 1, inComponent: 2, animated: true)
            }
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
                return 月份数组.count
            }
        case .年月日:
            if component == 0 {
                return 年份数组.count
            }else if component == 1 {
                return 月份数组.count
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
//                选中年 = "\(年份数组[row])"
            }else {
                str = "\(月份数组[row])月"
//                选中月 = "\(月份数组[row])"
            }
        case .年月日:
            if component == 0 {
                str = "\(年份数组[row])年"
//                选中年 = "\(年份数组[row])"
            }else if component == 1 {
                str = "\(月份数组[row])月"
//                选中月 = "\(月份数组[row])"
            }else {
                str = "\(日数组[row])日"
//                选中日 = "\(日数组[row])"
            }
        }
        
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: UIColor(hexColor: "1A1917")])
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //返回值
        if component == 0 {
            选中年 = "\(年份数组[row])"
            生成月数组()
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            选中月 = "\(月份数组[0])"
            生成日数组()
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            选中日 = "\(日数组[0])"
        }else if component == 1 {
            选中月 = "\(月份数组[row])"
            生成日数组()
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            选中日 = "\(日数组[0])"
        }else {
            选中日 = "\(日数组[row])"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    //MARK: 处理最晚日期 最早日期 很复杂
    private func 设置最晚(date: Date) {
        最晚年月日 = 分解返回年月日(Date: date)
    }
    
    private func 设置最早(date: Date) {
        最早年月日 = 分解返回年月日(Date: date)
        
    }
    
    private func 生成月数组() {
        
        guard let 年 = Int(选中年) else {return}
        月份数组.removeAll()
        
        if 年 == 最早年月日.年 && 年 == 最晚年月日.年 {
            for i in (最早年月日.月)...(最晚年月日.月) {
                月份数组.append(i)
            }
        }else {
            if 年 == 最早年月日.年 {
                
                for i in (最早年月日.月)...12 {
                    月份数组.append(i)
                }
            }else if 年 == 最晚年月日.年 {
                for i in 1...(最晚年月日.月) {
                    月份数组.append(i)
                }
            }else {
                月份数组 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
            }
        }
        
    }
    
    private func 生成日数组() {
        
        guard let 月 = Int(选中月) else {return}
        guard let 年 = Int(选中年) else {return}
        日数组.removeAll()
        
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM"
        let date = formate.date(from: "\(年)-\(月)")
        
        for i in 1...获取一个月的所有天(月: date!) {
            日数组.append(i)
        }
        
        
        if 年 == 最早年月日.年 {
            if 月 == 最早年月日.月 {
                日数组.removeAll()
                for i in (最早年月日.日)...(获取一个月的所有天(月: date!)) {
                    日数组.append(i)
                }
            }
            
        }
        if 年 == 最晚年月日.年 {
            
            if 月 == 最晚年月日.月 {
                日数组.removeAll()
                let upperDay = 获取一个月的所有天(月: date!)

                let range = upperDay > 最晚年月日.日 ? 最晚年月日.日 : upperDay
                for i in 1...range {
                    日数组.append(i)
                }
            }
        }
        
        if 年 == 最早年月日.年 && 年 == 最晚年月日.年 && 月 == 最早年月日.月 && 月 == 最晚年月日.月 {
            let upperDay = 获取一个月的所有天(月: date!)
            let range = upperDay > 最晚年月日.日 ? 最晚年月日.日 : upperDay
            日数组.removeAll()
            for i in (最早年月日.日)...range {
                日数组.append(i)
            }
        }
        
    }
    
    private func 分解返回年月日(Date: Date) -> (年: Int, 月: Int, 日: Int) {
        
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM-dd"
        
        let array = formate.string(from: Date).components(separatedBy: "-")
        guard array.count == 3 else {return (0,0,0)}
        
        return (Int(array[0])!, Int(array[1])!, Int(array[2])!)
    }
    
}
