// ViewController.swift  CodeShare
//  Created by ice on 2016/10/11.
//  Copyright © 2016年 k. All rights reserved.


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //设置不让系统自动控制 scrollView 的contentInsets
        self.automaticallyAdjustsScrollViewInsets = false
        
        //封装返回的按钮
        configBackItem()
        
        self.view.backgroundColor = UIColor.randomColor()
        
    }
    
    //封装返回按钮
    func configBackItem(){
        
            //判断是push进来的控制器 还是视图控制器present
        
            //视图控制器不是被present出来的(是被push出来的) 且 不是视图控制器管理的数组中的第一个 || 被present展示出来的  //这些视图都需要一个返回的按钮
            if (self.navigationController?.presentingViewController == nil && self.navigationController?.viewControllers.first != self) || self.presentingViewController != nil {  //该视图不是视图控制器管理的  第一个视图
                
                let backBtn = UIButton(type: .Custom)
                
                backBtn.setImage(UIImage(named: "返回按钮"), forState: .Normal)
                
                backBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside, withBlock: { (sender) in
                    
                    //如果是pop不成功,就让dismiss
                    if self.navigationController?.popViewControllerAnimated(true) == nil{
                        
                        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                })
                
                backBtn.frame = CGRectMake(0, 0, 16, 24)
                let backItem = UIBarButtonItem(customView: backBtn)
                self.navigationItem.leftBarButtonItem = backItem
                
            }
        
        
        //
        if self.navigationController?.presentationController == nil && self.navigationController?.viewControllers.count > 1 && self.navigationController?.viewControllers[2] == self{
            
            self.hidesBottomBarWhenPushed = true
        }
        
    }
    
    //在根控制器中写上公共的功能代码(点击屏幕,键盘收回)
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesBegan(touches, withEvent: event)
        
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//MARK: 扩展,方便获取tabbar navigationBar statusBar 等的高度

extension UIViewController{
    
    //扩展中必须写计算属性,不能写存储属性
    var statusBarHeight: CGFloat{
        
         return UIApplication.sharedApplication().statusBarFrame.height
    }
    
    //导航条的高度
    var naviBarHeight: CGFloat{
        return (self.navigationController?.navigationBar.frame.size.height)!
    }
    
    //标签栏的高度
    var tabBarHeight: CGFloat{
        //不是present出来的  且是导航器管理的第一个控制器
        if self.tabBarController != nil && self.navigationController?.viewControllers.first == self {
            
            
            return (self.tabBarController?.tabBar.frame.size.height)!
        }else{
            
            return 0
        }
        
    }
    
    //状态栏 + 导航条
    var topBarHeight: CGFloat{
        
        if self.navigationController != nil{
            
            return statusBarHeight + naviBarHeight
    
        }else{
            
            return 0
        }
    }
    
    
    
}

