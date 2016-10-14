//
//  CSMyVideoTableViewCell.swift
//  CodeShare
//
//  Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit


//我的视频自定义cell
class CSMyVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!

    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var videoImageView: UIImageView!
    
    //配置cell上的内容
    func configure(withModel model: CSMyVideoModel){
        
        titleLable.text = model.title
        sizeLabel.text = model.videoSize
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
