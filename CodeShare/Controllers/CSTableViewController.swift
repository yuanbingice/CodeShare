//
//  CSTableViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//有tableview的基类
class CSTableViewController: ViewController {
    
    var style: UITableViewStyle = UITableViewStyle.Grouped
    
    
    init(withStyle style: UITableViewStyle){
        
        self.style = style
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)  //防止xib创建时崩溃
    }
    
    //定义一 私用的懒加载类型的表格视图.并且只能get
    private(set) lazy var tableView: UITableView = {
    
        let style = self.style
        let tableView = UITableView.init(frame: CGRectZero, style: style)
        
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.backgroundColor = UIColor(red: 0.801, green: 0.801, blue: 0.801, alpha: 1.0)
        tableView.rowHeight = 64
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        return tableView
    }()
    
    //利用该属性的变化来  给表格视图的的边缘赋值
    var contentInset = UIEdgeInsetsZero{
        
        didSet{
            
            tableView.contentInset = contentInset
     
        }
        
        /*
         contentSize是scrollview可以滚动的区域，比如frame = (0 ,0 ,320 ,480) contentSize = (320 ,960)，代表你的scrollview可以上下滚动，滚动区域为frame大小的两倍。
         
         contentOffset是scrollview当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，contentoffset就是(0 ,480)，也就是y偏移了480
         
         contentInset是scrollview的contentview的顶点相对于scrollview的位置，例如你的contentInset = (0 ,100)，那么你的contentview就是从scrollview的(0 ,100)开始显示
         */
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        
        //表格视图的约束  和父视图的边界相等
        tableView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
        }
        
        //将scrollview上面的contentview从scrollview的(0 ,100)开始显示  //下面是设置边缘的大小
        contentInset = UIEdgeInsetsMake(topBarHeight, 0, tabBarHeight, 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
}

// MARK: 表格视图代理

extension CSTableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
}

