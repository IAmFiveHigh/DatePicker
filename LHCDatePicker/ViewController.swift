//
//  ViewController.swift
//  LHCDatepicker
//
//  Created by 每天农资 on 2018/5/14.
//  Copyright © 2018年 我是五高你敢信. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {

    let a = LHCDatepicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), 起始时间: "2018-3-20", position: .中心)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        a.dateType = .年月日
        a.delegate = self
        view.addSubview(a)
        
        let btn1 = UIButton(frame: CGRect(x: 20, y: 100, width: 120, height: 50))
        btn1.addTarget(self, action: #selector(修改最早日期), for: .touchUpInside)
        btn1.setTitle("修改最早日期", for: .normal)
        view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 200, y: 100, width: 120, height: 50))
        btn2.addTarget(self, action: #selector(修改最晚日期), for: .touchUpInside)
        btn2.setTitle("修改最晚日期", for: .normal)
        view.addSubview(btn2)
        
    }
    
    @objc private func 修改最早日期() {
        let time = "2018-4-15"
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-M-dd"
        a.minDate = formate.date(from: time)!
    }
    
    @objc private func 修改最晚日期() {
        let time = "2018-5-10"
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-M-dd"
        a.maxDate = formate.date(from: time)!
    }

}

extension ViewController: LHCDatePickerDelegate {
    func 点击确定(date: String) {
        print(date)
    }
    
    func 点击取消(date: String) {
        print(date)
    }

}


