//
//  CSShareViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/18.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture  //全屏侧滑返回,还可以
import YYKit


class CSShareViewController: CSScrollerViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //隐藏导航条
        self.fd_prefersNavigationBarHidden = true
        
        //利用YYKit中的  imageByBlurLight() 方法是图片模糊
        let backImage = UIImage(named: "image02")?.imageByBlurLight()
        self.view.backgroundColor = UIColor(patternImage: backImage!)
        
        // 给某个 view 加一个模糊效果
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Black
        self.view.insertSubview(toolBar, atIndex: 0)
        toolBar.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
        }
        
        let topBtn = UIButton(type: .Custom)
        topBtn.setImage(UIImage(named: "按钮-图片"), forState: .Normal)
        self.contentView.addSubview(topBtn)
        topBtn.snp_makeConstraints { (make) in
            
            make.centerY.equalTo(-140)
            make.centerX.equalTo(0)
            make.width.height.equalTo(56)
        }
        
        //跳转到图片分享的页面
        topBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            let shareVC = CSSharePhotoViewController()
            shareVC.title = "图片分享"
            shareVC.hidesBottomBarWhenPushed = true
            shareVC.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
            
            self.navigationController?.pushViewController(shareVC, animated: true)
        }
        
        
        let centerBtn = UIButton(type: .Custom)
        centerBtn.setImage(UIImage(named: "按钮-视频"), forState: .Normal)
        self.contentView.addSubview(centerBtn)
        centerBtn.snp_makeConstraints { (make) in
            
            make.center.equalTo(0)
            make.width.height.equalTo(topBtn)
        }
        
        
        let bottomBtn = UIButton(type: .Custom)
        bottomBtn.setImage(UIImage(named: "按钮-压缩包"), forState: .Normal)
        self.contentView.addSubview(bottomBtn)
        bottomBtn.snp_makeConstraints { (make) in
        
            make.width.height.equalTo(topBtn)
            make.centerX.equalTo(0)
            make.centerY.equalTo(140)
        }
        
        self.scrrollerView.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
