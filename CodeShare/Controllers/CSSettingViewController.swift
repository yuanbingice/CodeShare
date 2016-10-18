//
//  CSSettingViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/18.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit


//i设置界面
class CSSettingViewController: CSTableViewController {

    //包含 section(内部又包含row)  //row有3中cell,type为区分种类的标记
    let cellInfo = [
        [ //第一组section(一行)
            [
                "title": "个人信息",
                "type": "0",
            ]
        ], //第二组section(3行)
        [
            [
                "title": "允许查看我的分享",
                "type": "1",
            ],
            [
                "title": "允许查看我的下载",
                "type": "1",
            ],
            [
                "title": "任何人允许添加我为好友",
                "type": "1",
            ]
        ],
        [//第三组section(2行)
            [
                "title": "保存到本地",
                "type": "0",
            ],
            [
                "title": "账号绑定",
                "type": "0",
            ],
            
        ],
        [ //第四组section(三行)
            [
                "title": "清除缓存",
                "type": "2",
            ],
            [
                "title": "用户反馈",
                "type": "0",
            ],
            [
                "title": "关于",
                "type": "0",
            ]
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor ( red: 0.8603, green: 1.0, blue: 0.9747, alpha: 1.0 )
        //注册系统的cell
        self.tableView.registerClassOf(UITableViewCell)
        //行高要是相同 就设置属性
        self.tableView.rowHeight = 44
        self.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: 表格视图代理
extension CSSettingViewController{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return cellInfo.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellInfo[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell()
        //cell的样式
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.textColor = UIColor.darkTextColor()
        cell.textLabel?.text = cellInfo[indexPath.section][indexPath.row]["title"]
        
        //设置cell右边不同的样式
        let type = self.cellInfo[indexPath.section][indexPath.row]["type"]
        if type == "0"{
         
            cell.accessoryType = .DisclosureIndicator
            
        }else if type == "1"{
            
            //附加的视图
            cell.accessoryView = UISwitch()
            
        }else {
            
            cell.accessoryType = .None
        }
        
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0{
            
            //进到信息详情页面
            let detailVC = CSMyDetailViewController()
            detailVC.title = "信息详情"
            detailVC.contentInset = contentInset
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
    }
    
    
}

