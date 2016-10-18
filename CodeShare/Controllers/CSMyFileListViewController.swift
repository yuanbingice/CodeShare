
//
//  CsMyFileListViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/14.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//我的文件列表控制器

class CSMyFileListViewController: CSTableViewController {
    
    var cellModels: [AnyObject] = []

    var cellInfos = [
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ],
            [
                "title": "关于JavaScript.doc",
                "imageUrl": "",
                "fileSize": "34.8k",
                "from": "来自大熊的分享"
            ]
        ]

    override func viewDidLoad() {
        super.viewDidLoad()

        //给cellModels赋值(利用YYmodel) //创建数据模型
        self.cellModels = NSArray.modelArrayWithClass(CSMyFileModel.self, json: self.cellInfos)!
        
        //注册cell(利用自己封装的泛型方法)     //下面不需要强转为自定义的cell
        self.tableView.registerNibOf(CSMyFileTableViewCell)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK: 表格视图的代理

extension CSMyFileListViewController{
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //利用封装的泛型方法  获取 ***(不需要强转为自定义的),,,但需要在前面制定是哪种类型
        let cell: CSMyFileTableViewCell = tableView.dequeueReusableCell()
        
        cell.configureWithModel(cellModels[indexPath.row] as! CSMyFileModel)
        
        return cell
    }
    
}
