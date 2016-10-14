//
//  CSloginViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/11.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import SnapKit   //设置约束的库
import JKCategories
import Alamofire


class CSLoginViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录"
        
        view.backgroundColor = UIColor.whiteColor()
    
        //配置UI
        configUI()
        
    }
    
    
    func configUI(){
        
        //MARK: 用户名输入框
        let userName = UITextField()
        userName.placeholder = "请输入邮箱或手机号码"
        userName.font = UIFont.systemFontOfSize(15)
        userName.backgroundColor = UIColor.whiteColor()
        userName.clearButtonMode = .Always  //删除按钮一直显示
        self.view.addSubview(userName)
        
        //设置的约束必须要能唯一确定视图的位置和大小
        //确定userName文本输入框的约束   //Constraints  限制,约束
        userName.snp_makeConstraints { (make) -> Void in
        
            make.top.equalTo(100)   //距离父视图的顶部100
            make.left.equalTo(0)    //距离父视图的左边界 0
            make.right.equalTo(0)
            make.height.equalTo(48)   //高度
        }

        //设置输入框的边框
        userName.layer.borderColor = UIColor.grayColor().CGColor
        userName.layer.borderWidth = 1.0
        
        //输入框的左视图
        let nameLeft = UIView()
        //设置输入框左边的图片将其加入到nameLeft上面
        let nameImageView = UIImageView(image: UIImage(named: "用户图标"))
        nameLeft.addSubview(nameImageView)
        
        //将父视图nameLeft赋给文本输入框的左视图
        userName.leftView = nameLeft
        userName.leftViewMode = .Always   //需要让其一直显示
        //确定左视图的约束(左视图的大小)
        nameLeft.snp_makeConstraints { (make) -> Void in
            
            make.size.equalTo(CGSizeMake(64, 48))   //视图的大小
        }
        //确定左视图上 图片视图的约束  让其居中显示
        nameImageView.snp_makeConstraints { (make) -> Void in
            
            make.center.equalTo(0)   //中心和父视图中心重合
        }
        
        
        //MARK: 密码输入框
        let password = UITextField()
        password.placeholder = "请输入密码"
        password.font = UIFont.systemFontOfSize(15)
        password.clearButtonMode = .Always
        password.backgroundColor = UIColor.whiteColor()
        view.addSubview(password)
        //设置密码框的约束(必须有父视图)   //单独设置大小不需要
        password.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(userName.snp_bottom)  //顶部和账户输入框的下部坐标相等
            make.left.right.equalTo(0)  //左右和父视图的边界都为0
            make.height.equalTo(48)
        }
        password.layer.borderColor = UIColor.grayColor().CGColor
        password.layer.borderWidth = 1.0
        
        
        //输入框上的左视图
        let passLeft = UIView()
        let passImageView = UIImageView(image: UIImage(named: "密码图标"))
        passLeft.addSubview(passImageView)
        password.leftView = passLeft
        password.leftViewMode = .Always
        passLeft.snp_makeConstraints { (make) -> Void in
            
            make.size.equalTo(CGSizeMake(64, 48))
        }
        
        passImageView.snp_makeConstraints { (make) -> Void in
            
            make.center.equalTo(0)
        }
        
        
        //忘记密码按钮
        let forgetPass = UIButton(type: .Custom)
        
        forgetPass.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        forgetPass.setTitle("忘记密码?", forState: .Normal)
        
        forgetPass.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        view.addSubview(forgetPass)
        
        forgetPass.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(0)
            make.top.equalTo(password.snp_bottom)
            make.width.equalTo(72)
            make.height.equalTo(56)
        }
        
        //创建登录按钮
        let loginBtn = UIButton(type: .Custom)
        loginBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        loginBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginBtn.setTitle("登录", forState: .Normal)
        
        //设置按钮的背景颜色(正常状态/禁止状态/高亮状态)
        loginBtn.jk_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        loginBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        loginBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        loginBtn.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.1, alpha: 1)
        self.view.addSubview(loginBtn)
        
        loginBtn.snp_makeConstraints { (make) -> Void in
            
            make.left.right.equalTo(0)
            make.top.equalTo(forgetPass.snp_bottom).offset(100)  //偏移量,距离
            make.height.equalTo(48)
        }
        
        //MARK: 设置登录按钮的点击事件
        loginBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            //使用封装的方法快速进行网络请求
            CSNetHelp.request(parameters: [
                "service": "User.Login",
                "phone": userName.text!,
                "password": (password.text! as NSString).jk_md5String
                ]).responseJSON({ (data, success) in
                    
                    if success{ //请求成功
                        
                        print(data)
                        
                        CSUserModel.login(with: data as! [String: AnyObject])
                        
                        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
                        
                    }else{
                        
                        
                        UIAlertView(title: "有错误", message: data as? String, delegate: nil, cancelButtonTitle: "我知道了").show()
                        
                    }
                })
            
            
        }
        
        //MARK:  导航条上的按钮

        //导航上的注册按钮
        let registerBtn = UIButton(type: .Custom)
        registerBtn.frame = CGRectMake(0, 0, 44, 32)
        registerBtn.setTitle("注册", forState: .Normal)
        registerBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        registerBtn.addTarget(self, action: #selector(register), forControlEvents: .TouchUpInside)
        let registerBarBtn = UIBarButtonItem(customView: registerBtn)
        self.navigationItem.rightBarButtonItem = registerBarBtn
        
    }
    
    
    //注册按钮的方法.进入注册页面
    func register(){
        
        let registerVC = CSRegisterViewController()
        
        self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
