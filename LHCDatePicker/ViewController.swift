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
        
        let a = LHCDatepicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), 起始时间: "2017-01-01")
        a.dateType = .年月日
        view.addSubview(a)
        
    }

}


