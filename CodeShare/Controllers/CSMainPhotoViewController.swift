//
//  CSMainPhotoViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/17.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

class CSMainPhotoViewController: CSTableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClassOf(CSMainPhotoCell)
        //如果所有的cell高度一样就用属性(可以提高 tabelView 的性能),,, 不同时再用代理里面的方法
        tableView.rowHeight = 280
        //不允许点击cell
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension CSMainPhotoViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CSMainPhotoCell = tableView.dequeueReusableCell()
        
        return  cell
    }
    
}
