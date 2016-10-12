//
//  CSRegisterViewController.swift
//  CodeShare  Created by ice on 2016/10/11.
//  Copyright © 2016年 k. All rights reserved.

import UIKit
import JKCategories
import Alamofire
import ReactiveCocoa


class CSRegisterViewController: UIViewController {
    
    dynamic var time = -1   //要观察他的变化,则需要定义为动态的 -1 为正常状态,没有在读秒
    var timer: NSTimer!     //定时器

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "注册"
       
        //配置UI
        configUI()

    }
    
    func configUI(){
        
        //MARK: 用户名输入框
        let userName = UITextField()
        userName.placeholder = "请输入邮箱或手机号码"
        userName.clearButtonMode = .Always
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
        
        
        //用户名输入框的左视图
        let nameLeft = UIView()
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
        
        //MARK: 密码输入框
        let password = UITextField()
        password.placeholder = "请输入密码"
        password.font = UIFont.systemFontOfSize(15)
        password.clearButtonMode = .Always
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
        
        //密码输入框的左视图
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
        
        //验证码输入框
        let verifyTextField = UITextField()
        verifyTextField.placeholder = "请输入验证码"
        verifyTextField.font = UIFont.systemFontOfSize(15)
        verifyTextField.backgroundColor = UIColor.whiteColor()
        
        //验证码输入框右侧的视图中的按钮
        let verifyButton = UIButton(type: .Custom)
        verifyButton.setTitle("获取验证码", forState: .Normal)
        verifyButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
        verifyButton.titleLabel?.font = UIFont.systemFontOfSize(15)

        verifyButton.jk_setBackgroundColor(UIColor.whiteColor(), forState: .Normal)
        verifyButton.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        verifyButton.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        
        //验证码输入框的右侧视图
        let rightView = UIView()
        rightView.addSubview(verifyButton)
        verifyTextField.rightView = rightView
        verifyTextField.rightViewMode = .Always
        
        //验证码输入框的左侧视图
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
        
        //按钮的边框
        verifyButton.layer.borderColor = UIColor.grayColor().CGColor
        verifyButton.layer.borderWidth = 1.0
        verifyButton.layer.cornerRadius = 3.0  //圆角半径(拐角半径)
        //verifyButton.clipsToBounds = true   //将裁剪边界置为true,用了下面的方法可以不用裁剪
        //让背景颜色显示在视图范围内(不会超出范围)
        verifyButton.layer.masksToBounds = true
        
        
        //MARK:  注册按钮
        let registerBtn = UIButton(type: .Custom)
        registerBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        registerBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerBtn.setTitle("注册", forState: .Normal)
        //开始不能点击注册按钮
        registerBtn.enabled = false
        
        //设置按钮的背景颜色(正常状态/禁止状态/高亮状态)
        registerBtn.jk_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        registerBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        registerBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        
        registerBtn.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.1, alpha: 1)
        self.view.addSubview(registerBtn)
        
        registerBtn.snp_makeConstraints { (make) -> Void in
            
            make.left.right.equalTo(0)
            make.top.equalTo(verifyTextField.snp_bottom).offset(100)  //偏移量,距离
            make.height.equalTo(48)
            
        }
        
        //刚开始不能点击按钮
        verifyButton.enabled = false
        
//        //textfield继承uicontrol,判断输入框的输入字符个数是否为11位
//        userName.jk_handleControlEvents(UIControlEvents.EditingChanged) { (sender) in
//            
//            verifyButton.enabled = userName.text?.lengthOfBytesUsingEncoding(NSStringEncoding(NSUTF8StringEncoding)) == 11
//            
//        }
        
        //MARK: 订阅信号,实现按钮的状态改变
        
        //用rac 订阅输入框的信号, 根据输入的内容,改变按钮的状态 //subscribe(订购,订阅)
        userName.rac_textSignal().subscribeNext { (sender) in
            
            let name = sender as! NSString
            //如果输入位数为11位,改变按钮的状态,并且要在正常状态下才将 验证码的按钮置为true
            verifyButton.enabled = (name.length == 11 && self.time == -1)
            
//            //大于11位后
//            if name.length >= 11{
//                //会自动跳到密码输入框
//                password.becomeFirstResponder()
//            }
        }
        
        //将几个信号合并为一个信号,订阅并改变注册按钮的状态  //combine(合并,使合并)
        userName.rac_textSignal()
        .combineLatestWith(password.rac_textSignal())
        .combineLatestWith(verifyTextField.rac_textSignal())
        .subscribeNext { (sender) in
            
            registerBtn.enabled = ((userName.text! as NSString).length == 11 && (password.text! as NSString).length >= 6 && (verifyTextField.text! as NSString).length == 4)
        }
        
        /*
        //用热信号的方式实现这个需求
        userName.rac_textSignal().toSignalProducer()
            .combineLatestWith(password.rac_textSignal().toSignalProducer())
        .combineLatestWith(verifyTextField.rac_textSignal().toSignalProducer())
        
        .startWithNext { (signal1, signal2) in
            
            print("signal1:\(signal1) signal2: \(signal2)")
        }
        */
        
        
        //也可以把按钮的点击事件当做信号来订阅
        registerBtn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (sender) in
            
            print( sender as! UIButton)
        }
        
        //将变量的改变当做信号来订阅(代替 KVO)
//        self.rac_observeKeyPath("time", options: NSKeyValueObservingOptions.New, observer: self) { (value, timeInfo, bool1, bool2) in
//            
//            print("\(value), \(timeInfo) \(bool1) \(bool2) \(self.time)")
//        }
        
        //订阅time的变化信息(上边的方法也可以代替KVO)
        //使用mvc的思想,如果数据改变了,界面跟着改变   // 这里面读取到的time一直在变化
        self.rac_valuesForKeyPath("time", observer: self).subscribeNext { (time) in
            
            //先根据time的值 来确定按钮的状态
            verifyButton.enabled = (self.time == -1)
        
            if self.time == -1{ //time值变为-1,则将定时器停止
                
                if self.timer != nil{
                    
                    self.timer.invalidate()  //将定时器无效化
                }
                verifyButton.setTitle("获取验证码", forState: UIControlState.Normal)
            }else{  //time还在读数中,改变按钮的标题
                
                verifyButton.setTitle("还剩\(self.time)秒", forState: UIControlState.Normal)
            }
        }
        
        
        //MARK: 获取验证码按钮的点击事件
        verifyButton.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            //按钮禁止
            verifyButton.enabled = false
        
            self.time = 30  //每次点击成功后让倒计时
            
            //获取验证码
            SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethod.init(0), phoneNumber: userName.text!, zone: "86", customIdentifier: nil) { (error) in
                
                if let tmpError = error{
                    
                    print(tmpError)
                   
                    //将time重新设置为-1 , 如果符合条件,按钮依然是正常的
                    self.time = -1
                    
                    
                }else{ //读秒
                    
                    
                    //开启一个定时器
                    self.timer = NSTimer.jk_scheduledTimerWithTimeInterval(1.0, block: {
                    
                        self.time -= 1  //将值改变
                    
                        //print(self.time,"在定中")
                    }, repeats: true) as! NSTimer
                    
                }
            }
        }
        
        
        //MARK: 设置注册按钮的点击事件
        registerBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            //密码用MD5加密
            Alamofire.request(.POST, "https://www.1000phone.tk", parameters: [
                "service": "User.Register",
                "phone": userName.text!,
                "password": (password.text! as NSString).jk_md5String,
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
        
        //MD5 没有解密过程,只是对数据进行特征加密,会破坏原数据的意义
        
        //真正的加密算法: RAS DES ... 这些加密算法,可以通过密钥解密处原始数据,所以除了密码之外的一些信息,可能会用这种加密方法
        
        
        
        //处理键盘遮挡视图的问题(代替通知)  //键盘的frame将要改变
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil)
        .subscribeNext { (noti) in
            
            
            let userInfo = (noti as! NSNotification).userInfo
            
            let rect = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            print(rect)
            
            //用SnapKit 给注册按钮做一个动画
            //如果更改一个视图的约束,需要使用snp_update
            registerBtn.snp_updateConstraints(closure: { (make) in
                
                make.top.equalTo(verifyTextField.snp_bottom).offset(20)
                
            })
            
            UIView.animateWithDuration(0.25, animations: {
                registerBtn.layoutIfNeeded()  //需要布局
            })
        }
        
        //键盘消失
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillHideNotification, object: nil).subscribeNext { (noti) in
            
            //当键盘消失,我们只需要将约束更新为原始状态即可
            registerBtn.snp_updateConstraints(closure: { (make) in
                
                make.top.equalTo(verifyTextField.snp_bottom).offset(100)
                
            })
            
            UIView.animateWithDuration(0.5, animations: {
                registerBtn.layoutIfNeeded()  //需要布局
            })
            
        }
        
        
        
    }
    
    //全屏的点击后,拉下软键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true) //视图或者视图上面的子视图放弃第一响应者
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
