//
//  CSScrollerViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/14.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//拥有滚动视图的视图控制器的基类

class CSScrollerViewController: ViewController {


    //创建私有的滚动视图
    private(set) lazy var scrrollerView: UIScrollView = {
       
        let scrollerView = UIScrollView.init()
        
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.backgroundColor = UIColor.whiteColor()
        
        
        return scrollerView
    }()
    
    //滚动视图上的视图,用来管理滚动视图上需要滚动的  东西
    private(set) lazy var contentView: UIView = {
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.randomColor()
        
        return contentView
    }()
    
    //滚动视图的边缘设置,类似前面表格视图的
    var contentInset = UIEdgeInsetsMake(64, 0, 0, 0){
        
        didSet{
            
            scrrollerView.contentInset = contentInset
            scrrollerView.scrollIndicatorInsets = contentInset
            scrrollerView.contentOffset = CGPointMake(0, -contentInset.top)
            
            //更新 contentView 的高度约束
            
            contentView.snp_updateConstraints { (make) in
                
                make.height.greaterThanOrEqualTo(view).offset(1 - contentInset.top - contentInset.bottom)  //更到一个contentInset 的高度
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(scrrollerView)  //此处已经创建了 scrrollerView
        scrrollerView.addSubview(contentView)
        
        //需要在 scrollView 内部添加一个内容视图, 将 scrollView 撑起来
        contentView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
            //相互设置   //宽等于滚动视图的宽
            make.width.equalTo(scrrollerView)
            //大于或者等于
            make.height.greaterThanOrEqualTo(view).offset(1)
        }
        
        scrrollerView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
            make.bottom.equalTo(contentView.snp_bottom)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
