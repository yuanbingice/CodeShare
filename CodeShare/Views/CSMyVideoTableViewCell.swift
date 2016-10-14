//
//  CSMyVideoTableViewCell.swift
//  CodeShare
//
//  Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

class CSMyVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!

    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var videoImageView: UIImageView!
    
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
