//
//  CSMyVideoViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import YYKit

//我的视频 页面控制(继承基类的表格视图控制器类)
class CSMyVideoViewController: CSTableViewController {

    //构造假数据
    var cellInfos: [[String:String]] = []
    
    //模拟数据模型
    var cellModel: [AnyObject] = []
    
    //重写该方法,将style写死  //创建时会调用该方法(指定构造器)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(withStyle: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //配置数据
        self.getData()
        
        //注册cell(xib拖拽)
        self.tableView.registerNib(UINib(nibName: String(CSMyVideoTableViewCell),bundle: nil), forCellReuseIdentifier: String(CSMyVideoTableViewCell))
        
        
    }

    //配置数据
    func getData(){
        
        cellInfos = [
            [
                "title": "杭州铁笼沉尸案主犯获死刑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "杭州铁笼沉尸案主犯获死刑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "杭州铁笼沉尸案主犯获死刑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
            [
                "title": "河南政府吃饭打白条欠120万，字数不够还得凑",
                "imageUrl": "视频",
                "videoUrl": "http://www.baidu.com"
            ],
        ]
        
        //给model赋值(利用YYKit中的YYModel,用起来比利用KVC方便)
        cellModel = NSArray.modelArrayWithClass(CSMyVideoModel.self, json: cellInfos)!
        //刷新表格视图
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: 表格视图的代理

extension CSMyVideoViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellModel.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CSMyVideoTableViewCell)) as! CSMyVideoTableViewCell
        
        cell.configure(withModel: cellModel[indexPath.row] as! CSMyVideoModel)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //反选
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}



