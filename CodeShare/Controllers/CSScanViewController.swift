//
//  CSScanViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/18.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

import swiftScan

//扫一扫界面

class CSScanViewController: LBXScanViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        print(arrayResult)
        
        //在这里根据扫描到的不同结果,做不同的处理
        // 比如如果扫到一个网站，跳转到网站
        // 如果扫到的是用户的信息，就加对方为好友
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
