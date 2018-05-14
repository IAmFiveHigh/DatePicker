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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = LHCDatepicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), 起始时间: "2017-11-20")
        a.dateType = .年月日
        a.delegate = self
        view.addSubview(a)
        
        
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


