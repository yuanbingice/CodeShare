//
//  CSMyFileTableViewCell.swift
//  CodeShare
//
//  Created by ice on 2016/10/14.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//我的文件 自定义cell
class CSMyFileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sizeLable: UILabel!

    @IBOutlet weak var formLabel: UILabel!
    


    
    func configureWithModel(model: CSMyFileModel) {
        
        titleLabel.text = model.title
        sizeLable.text = model.fileSize
        formLabel.text = model.form
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
