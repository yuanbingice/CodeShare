//
//  CSTabBarController.swift
//  CodeShare
//
//  Created by ice on 2016/10/11.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

class CSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //配置标签栏内的导航器
    func configureViewController(){
        
        let vcInfos = [
            
            ["title": "主页", "image": "tabbar_1", "class": "UIViewController"],
            ["title": "消息", "image": "tabbar_1", "class": "UIViewController"],
            ["title": "聊天", "image": "tabbar_1", "class": "UIViewController"],
            ["title": "我的", "image": "tabbar_1", "class": "UIViewController"]
        
        ]
        
        var vcArr: [UINavigationController] = []
        
        for vcInfo in vcInfos{
            
            let vc = (NSClassFromString(vcInfo["class"]!) as! UIViewController.Type).init()
            
            vc.title = vcInfo["title"]
            
            vc.view.backgroundColor = UIColor.whiteColor()
            
            let navVC = UINavigationController(rootViewController: vc)
            
            vcArr.append(navVC)
            
        }
        
        self.viewControllers = vcArr
    }
    
    //视图完成显示,推出登录页面
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let loginVC = UINavigationController(rootViewController: CSLoginViewController())
        
        loginVC.view.backgroundColor = UIColor.whiteColor()
        
        self.presentViewController(loginVC, animated: true, completion: nil)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
