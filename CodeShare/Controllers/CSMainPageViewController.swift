//
//  CSMainPageViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/17.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//继承可以管理视图控制器的
class CSMainPageViewController: YZDisplayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //配置管理的子视图控制器(利用的是第三方库,继承YZDisplayViewController)
        configureViewControllers()
        
    }
    //配置管理的子视图控制器
    func configureViewControllers(){
        
        let mainPhoto = CSMainPhotoViewController()
        mainPhoto.style = .Plain
        mainPhoto.title = "图片"
        mainPhoto.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainPhoto)
        
        let mainVideo = CSMainVideoViewController()
        mainVideo.style = .Plain
        mainVideo.title = "视频"
        mainVideo.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainVideo)
        
        let mainFile = CSMainFileViewController()
        mainFile.style = .Plain
        mainFile.title = "压缩包"
        mainFile.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainFile)
        
        //将活动的标题视图 赋值给 导航条上的 标题视图
        self.navigationItem.titleView = self.titleScrollView
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
