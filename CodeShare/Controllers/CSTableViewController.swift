// CSTableViewController.swift  CodeShare
// Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.

import UIKit


//有tableview视图控制器的基类
class CSTableViewController: ViewController {
    
    //属性用来定义表格视图的方式,下面创建表格视图时会利用这个竖向
    var style: UITableViewStyle = UITableViewStyle.Grouped
    
    //便利构造器
    init(withStyle style: UITableViewStyle){
        
        self.style = style
        
        super.init(nibName: nil, bundle: nil)  //指定构造器
        
    }
    
    //该构造方法 是指定构造器, 便利构造器会调用 //不重写该方法下面的tableview 是错误类型
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)   //防止xib创建时崩溃,该构造方法xib创建时会调用
    }
    
    //定义 (私用的懒加载类型的表格视图.并且只能get)   //利用闭包返回
    private(set) lazy var tableView: UITableView = {
    
        let style = self.style
        let tableView = UITableView.init(frame: CGRectZero, style: style)  //下面设置了约束 snp, 此处frame不会起作用
        //关闭水平提示条
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.backgroundColor = UIColor(red: 0.801, green: 0.801, blue: 0.801, alpha: 1.0)
        tableView.rowHeight = 64  //cell的高度
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        return tableView
    }()
    
    //利用该属性的变化来  给表格视图的的边缘赋值  //子类会继承
    var contentInset = UIEdgeInsetsZero{
        
        didSet{
            
            // 当我们在外部自定义 contentInset 时候，我们在这里修改 tableView 的 contentInset 和指示器，防止导航条或者 tabBar 遮挡住 tableView 内容
            
            //防止导航条或者tabBar遮挡住tableview内容
            tableView.contentInset = contentInset
            
            //将滚动提示条的位置也改变
            tableView.scrollIndicatorInsets = contentInset
            
            //设置偏移量,防止进入页面tableview被挡住 //写正数就相当于向上滑了一段, 所以负数就会向下滑,会再起始位置漏出上面的 titleView
            tableView.contentOffset = CGPointMake(0, -contentInset.top)
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
       // contentInset = UIEdgeInsetsMake(topBarHeight, 0, tabBarHeight, 0)
        
    
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
}

// MARK: 表格视图代理

extension CSTableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("子类重写该方法")
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("子类重写该方法")
        
        return UITableViewCell()
    }
    
}

