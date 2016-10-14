//
//  CSTabBarController.swift
//  CodeShare
//  Created by ice on 2016/10/11.
//  Copyright © 2016年 k. All rights reserved.

import UIKit

class CSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        
    }
    //
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //配置标签栏内的导航器
    func configureViewController(){
        
        let vcInfos = [
            
            ["title": "主页", "image": "按钮主页", "class": "CodeShare.ViewController"],
            ["title": "消息", "image": "按钮消息", "class": "CodeShare.ViewController"],
            ["title": "分享", "image": "按钮分享", "class": "CodeShare.CSScrollerViewController"],
            ["title": "我的", "image": "按钮我的", "class": "CodeShare.CSMyInfoViewController"]
        
        ]
        
        var vcArr: [UINavigationController] = []
        
        for vcInfo in vcInfos{
            
            // swift 中，通过字符串获取一个类，需要在类名前加上工程名，还需要将类强转一下
            let vc = (NSClassFromString(vcInfo["class"]!) as! UIViewController.Type).init()
            
            vc.title = vcInfo["title"]
            
            let navVC = UINavigationController(rootViewController: vc)
            
            vcArr.append(navVC)
            
        }
        
        self.viewControllers = vcArr
        
        //设置 tabBar 按钮图片  //遍历标签栏中管理的项目
        var i = 0
        for tabBarItem in self.tabBar.items!{
         
            tabBarItem.image = UIImage(named: vcInfos[i]["image"]!)
            
            i += 1
        }
        
        //设置选中状态下tabBar的颜色
        self.tabBar.tintColor = UIColor ( red: 0.5725, green: 0.7961, blue: 0.2549, alpha: 1.0 )
        
    }
    
    //视图完成显示,推出登录页面
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //如果用户未登录才弹出登录界面
        
        if CSUserModel.isLogin() == false{
        
            let loginVC = UINavigationController(rootViewController: CSLoginViewController())
            
            loginVC.view.backgroundColor = UIColor.whiteColor()
            
            self.presentViewController(loginVC, animated: true, completion: nil)
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
