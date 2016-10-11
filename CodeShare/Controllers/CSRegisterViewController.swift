//
//  CSRegisterViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/11.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import JKCategories
import Alamofire

class CSRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "注册"
        
        
        //用户名输入框
        let userName = UITextField()
        userName.placeholder = "请输入邮箱或手机号码"
        userName.font = UIFont.systemFontOfSize(15)
        userName.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(userName)
        //设置的约束必须要能唯一确定视图的位置和大小
        //确定userName文本输入框的约束
        userName.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(100)  //距离父视图的顶部100
            make.left.equalTo(0)   //距离父视图的左边界 0
            make.right.equalTo(0)
            make.height.equalTo(48)  //高度
        }
        
        //设置输入框的边框
        userName.layer.borderColor = UIColor.grayColor().CGColor
        userName.layer.borderWidth = 1.0
        
        //两个父视图
        let nameLeft = UIView()
        let passLeft = UIView()
        
        
        //设置输入框左边的图片将其加入到nameLeft上面
        let nameImageView = UIImageView(image: UIImage(named: "用户图标"))
        nameLeft.addSubview(nameImageView)
        
        //将父视图nameLeft赋给文本输入框的左视图
        userName.leftView = nameLeft
        userName.leftViewMode = .Always   //需要让其一直显示
        
        //确定左视图的约束
        nameLeft.snp_makeConstraints { (make) -> Void in
            
            make.size.equalTo(CGSizeMake(64, 48))   //视图的大小
        }
        
        //确定左视图上 图片视图的约束  让其居中显示
        nameImageView.snp_makeConstraints { (make) -> Void in
            
            make.center.equalTo(0)   //中心和父视图中心重合
        }
        
        //密码输入框
        let password = UITextField()
        password.placeholder = "请输入密码"
        password.font = UIFont.systemFontOfSize(15)
        password.backgroundColor = UIColor.whiteColor()
        password.secureTextEntry = true
        view.addSubview(password)
        
        //设置密码框的约束(必须有父视图)   //单独设置大小不需要
        password.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(userName.snp_bottom)  //顶部和账户输入框的下部坐标相等
            make.left.right.equalTo(0)  //左右和父视图的边界都为0
            make.height.equalTo(48)
        }
        
        password.layer.borderColor = UIColor.grayColor().CGColor
        password.layer.borderWidth = 1.0
        
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
        
        //验证码输入框
        let verifyTextField = UITextField()
        verifyTextField.placeholder = "请输入验证码"
        verifyTextField.font = UIFont.systemFontOfSize(15)
        verifyTextField.backgroundColor = UIColor.whiteColor()
        
        
        let verifyButton = UIButton(type: .Custom)
        verifyButton.setTitle("获取验证码", forState: .Normal)
        verifyButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
        verifyButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        //verifyButton.titleLabel?.tintColor = UIColor.greenColor()
        verifyButton.jk_setBackgroundColor(UIColor.whiteColor(), forState: .Normal)
        verifyButton.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        verifyButton.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        
        let rightView = UIView()
        rightView.addSubview(verifyButton)
        
        let leftView = UIView()
        
        let verifyImageView = UIImageView(image: UIImage(named: "验证信息图标"))
        leftView.addSubview(verifyImageView)
        verifyTextField.leftView = leftView
        verifyTextField.leftViewMode = .Always
        
        view.addSubview(verifyTextField)
        
        //约束//验证码输入框
        verifyTextField.snp_makeConstraints { (make) in
            
            make.top.equalTo(password.snp_bottom).offset(50)
            make.left.right.equalTo(0)
            make.height.equalTo(48)
        }
        
        verifyTextField.layer.borderColor = UIColor.grayColor().CGColor
        verifyTextField.layer.borderWidth = 1.0
        
        //输入框右视图的大小
        rightView.snp_makeConstraints { (make) in
            
            make.size.equalTo(CGSizeMake(90, 48))
        }
        
        //右视图内部视图与右视图的约束
        verifyButton.snp_makeConstraints { (make) in
            
            make.center.equalTo(0)
            make.left.equalTo(3)
            make.top.equalTo(8)
        }
        
        
        leftView.snp_makeConstraints { (make) in
            
            make.size.equalTo(CGSizeMake(64, 48))
        }
        
        //左视图内部视图与右视图的约束
        verifyImageView.snp_makeConstraints { (make) in
            
            
            make.center.equalTo(0)
        }
        
        verifyTextField.rightView = rightView
        verifyTextField.rightViewMode = .Always
        
        //按钮的边框
        verifyButton.layer.borderColor = UIColor.grayColor().CGColor
        verifyButton.layer.borderWidth = 1.0
        verifyButton.layer.cornerRadius = 3.0  //圆角半径(拐角半径)
        //verifyButton.clipsToBounds = true   //将裁剪边界置为true,用了下面的方法可以不用裁剪
        //让本惊颜色范围在视图范围内
        verifyButton.layer.masksToBounds = true
        
        
        
        //注册按钮
        let registerBtn = UIButton(type: .Custom)
        registerBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        registerBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerBtn.setTitle("注册", forState: .Normal)
        
        //设置按钮的背景颜色(正常状态/禁止状态/高亮状态)
        registerBtn.jk_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        registerBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        registerBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        

        registerBtn.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.1, alpha: 1)
        self.view.addSubview(registerBtn)
        
        registerBtn.snp_makeConstraints { (make) -> Void in
            
            make.left.right.equalTo(0)
            make.top.equalTo(verifyTextField.snp_bottom).offset(50)  //偏移量,距离
            make.height.equalTo(48)
        }
        
        //设置登录按钮的点击事件
        registerBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            Alamofire.request(.POST, "https://www.1000phone.tk", parameters: [
                "service": "User.Register",
                "phone": userName.text!,
                "password": password.text!,
                "verificationCode": verifyTextField.text!
                ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: { (response) in
                    
                    switch response.result{
                        
                    case .Success(let jsonData):
                        
                        print(jsonData)
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    case .Failure(let error):
                        
                        print(error)
                    }
                })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
