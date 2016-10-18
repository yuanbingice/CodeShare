//
//  CSMyRCodeViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/18.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

import swiftScan  //二维码扫描


//我的二维码页面
class CSMyRCodeViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let qrCodeView = UIImageView()
        
        self.view.addSubview(qrCodeView)
        
        qrCodeView.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(0)
            make.top.equalTo(100)
            make.width.height.equalTo(300)
        }
        
        //生成二维码
        let qrImage = LBXScanWrapper
            .createCode("CIQRCodeGenerator", codeString: "https://www.baidu.com", size: CGSizeMake(300, 300), qrColor: UIColor ( red: 0.7155, green: 0.6918, blue: 0.9992, alpha: 1.0 ), bkColor: UIColor.whiteColor())
        qrCodeView.image = qrImage
        
        
        //保存按钮
        let leftSave = UIButton(type: .Custom)
        leftSave.setTitle("截图保存", forState: .Normal)
        self.view.addSubview(leftSave)
        
        leftSave.jk_setBackgroundColor(UIColor.brownColor(), forState: .Normal)
        leftSave.snp_makeConstraints { (make) in
            
            make.left.equalTo(100)
            make.top.equalTo(qrCodeView.snp_bottom).offset(24)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        let rightSave = UIButton(type: .Custom)
        rightSave.setTitle("直接保存", forState: .Normal)
        self.view.addSubview(rightSave)
        
        rightSave.jk_setBackgroundColor(UIColor.purpleColor(), forState: .Normal)
        rightSave.snp_makeConstraints { (make) in
            
            make.right.equalTo(-60)
            make.top.equalTo(leftSave)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        //保存事件
        leftSave.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            //截图
            let screenImage = self.view.jk_screenshot()
            
            //保存到相册
            UIImageWriteToSavedPhotosAlbum(screenImage, self, #selector(CSMyRCodeViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    
    }
    
    //保存到相册需要调用的方法
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>
        ){ //第三个参数指针
        
        if error != nil{
            
            
        }else{
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
