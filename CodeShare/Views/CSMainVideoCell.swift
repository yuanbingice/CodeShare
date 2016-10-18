//
//  CSMainVideoCell.swift
//  CodeShare
//
//  Created by ice on 2016/10/17.
//  Copyright © 2016年 k. All rights reserved.


import UIKit


//主页的视频cell
class CSMainVideoCell: UITableViewCell {
    
    var startPlay: (() -> ())?
    
    //记录是否播放状态
    var isPlaying = false
    
    @IBOutlet weak var playerButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    //按钮点击的响应方法
    @IBAction func playerAction(sender: AnyObject) {
        
        self.startPlay!() //调用闭包
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
