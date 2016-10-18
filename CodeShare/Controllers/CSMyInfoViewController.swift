//
//  CSMyInfoViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/14.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//我的页面   //分为上半部分  和 下半部分(一个主视图控制器,管理三个视图控制器)

class CSMyInfoViewController: CSScrollerViewController {

     //一个主控制器 //利用第三方库
    var displayController = YZDisplayViewController()
    
    var headImageView = UIImageView(image: UIImage(named: "头像"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //封装展示多个子控制器
        configureViewController()
        
        //设置自身的 contentInset 在导航条和标签栏之间
        self.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        
        //设置 主视图控制器displayController的 titleScrollView 的样式
        configureTitleScroll()
        
        //设置上半部分的展示界面
        configureTopInfo()
        
    }
    //设置上半部分的展示界面
    func configureTopInfo(){
        
        let backImageView = UIImageView(image: UIImage(named: "背景图片"))
        self.contentView.addSubview(backImageView)
        backImageView.snp_makeConstraints { (make) in
            
            make.top.equalTo(16)
            make.left.right.equalTo(0)
            make.height.equalTo(140)
        }
        
        
        backImageView.addSubview(headImageView)
        headImageView.snp_makeConstraints { (make) in
            
            make.left.top.equalTo(16)
            make.width.height.equalTo(56)
        }
        
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(16)
        nameLabel.textColor = UIColor.whiteColor()
        backImageView.addSubview(nameLabel)
        nameLabel.text = "大熊猫"
        nameLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(headImageView.snp_right).offset(8)
            make.top.equalTo(headImageView)
        }
        
        
        let emailLabel = UILabel()
        emailLabel.font = UIFont.systemFontOfSize(15)
        emailLabel.textColor = UIColor.whiteColor()
        backImageView.addSubview(emailLabel)
        emailLabel.text = "110.qq.com"
        emailLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImageView)
        }
        
        let setButton = UIButton(type: .Custom)
        setButton.setTitle("设置", forState: .Normal)
        setButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        backImageView.addSubview(setButton)
        backImageView.userInteractionEnabled = true
        setButton.snp_makeConstraints { (make) in
            
            make.right.equalTo(-16)
            make.centerY.equalTo(0) //Y方向居中
        }
        
        setButton.jk_handleControlEvents(.TouchUpInside) { (sender) in
            
            let settingVC = CSSettingViewController()
            settingVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController( settingVC, animated: true)
        }
        
        
        //下方三个按钮
        let btnArr = ["12\n我的分享", "2\n我的下载", "1\n我的好友"]
        
        //作为中间变量来判断管理 约束
        var lastView: UIButton? = nil
        
        for btnTitle in btnArr{
            
            let button = UIButton(type: .Custom)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.titleLabel?.textAlignment = .Center
            button.titleLabel?.numberOfLines = 0
            
            button.jk_setBackgroundColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15), forState: .Normal)
            button.setTitle(btnTitle, forState: .Normal)
            backImageView.addSubview(button)
            
            button.snp_makeConstraints(closure: { (make) in
                
                //左侧第一个为0(lastView为nil)
                make.left.equalTo(lastView == nil ? backImageView.snp_left : (lastView?.snp_right)!).offset(lastView == nil ? 0 : 1)
                
                //divide 除以
                make.width.equalTo(backImageView).dividedBy(btnArr.count)
            
                
                make.height.equalTo(44)
                make.bottom.equalTo(0)
            })
         
            lastView = button  //刚开始为nil 所以为最左边,下次就变为第一个,一次向右排序
        }
        
    }
    
    
    //设置 titleScrollView 的样式
    func configureTitleScroll(){
        
        //设置下划线
        displayController.setUpUnderLineEffect { (isShowUnderLine, isDelayScroll, linHeight, lineColor) in
            
            isShowUnderLine.memory = true
            
            lineColor.memory = UIColor.randomColor()
            
        }
        
        //标题颜色效果(歌词颜色渐变的效果)
        displayController.setUpTitleGradient { (isShowTitleGradient, titleGradientStyle, startR, startG, startB, endR, endG, endB) in
            
            isShowTitleGradient.memory = true
            
            titleGradientStyle.memory = YZTitleColorGradientStyleFill
            
            startR.memory = 0.5
            startG.memory = 0.5
            startB.memory = 0.5
            
            endR.memory = 0.75
            endG.memory = 0.75
            endB.memory = 0.75
        }
    }

    func configureViewController(){
        
        //一个主控制器
    //    let displayController = YZDisplayViewController()
        
        //3个子控制器,并加入到主控制器中去
        let picList = CSMyPhotoListViewController()
        picList.title = "图片"
        displayController.addChildViewController(picList)
        
        let videoList = CSMyVideoViewController(nibName: nil, bundle: nil)
        videoList.title = "视频"
        videoList.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        displayController.addChildViewController(videoList)
        
        
        let fileList = CSMyFileListViewController()
        fileList.title = "压缩包"
        fileList.style = .Plain
        fileList.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        displayController.addChildViewController(fileList)
        
        //将 YZDisplayViewController(主控制器) 加入到本控制器下 并展示
        self.addChildViewController(displayController)
        self.contentView.addSubview(displayController.view) //将主控制器的view 加入到 封装的滚动视图的 contentView 上面
        
        //配置控制器的大小,让子控制器的 view 大小可以根据本控制器的 view 改变而改变 (也可以用约束,此处只是另外一种方法)
//        displayController.view.frame = self.view.bounds
//        displayController.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        
        displayController.view.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(156)  //距离顶部160
            
        }
        
        displayController.view.backgroundColor = UIColor.whiteColor()
        
        //控制器的生命周期  //parent 父亲 //告知移动到了父控制器中
        displayController.didMoveToParentViewController(self)
  
        //会放在导航条上面
//        self.navigationItem.titleView = displayController.titleScrollView
        //主视图控制器上的 标题视图  (可以像滚动视图滑动)
        displayController.titleScrollView.backgroundColor = UIColor(red: 0.7405, green: 0.8365, blue: 0.8648, alpha: 0.8)
        
    }
    
    //视图将要显示
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        headImageView.setImageWithURL(NSURL.init(string: CSUserModel.SharedUser.avatar))
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
