//
//  CSMyPhotoCollectionViewCell.swift
//  CodeShare
//
//  Created by ice on 2016/10/14.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//集合视图的自定义cell
class CSMyPhotoCollectionViewCell: UICollectionViewCell {

    //添加一个视图  // 用来展示高亮的效果
    var mask = UIView()
    
    
    
    //重写,因为需要添加一个子视图
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //固定的
        let imageView = UIImageView(image: UIImage(named: "图片"))
        self.contentView.addSubview(imageView)  //必须加到contentView上面,与表格视图的cell相似
        
        imageView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
        }
        
        //自己需要添加的视图  要添加到contentView上面
        self.contentView.addSubview(mask)
        
        mask.backgroundColor = UIColor(red: 0.2213, green: 0.2213, blue: 0.2213, alpha: 0.66)     //这里面的alpha只会影响自身
        mask.alpha = 0     //该属性响应子视图, 默认为0(透明)
        
        mask.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
        }
        
    }

    
    //重写高亮状态  // 发生改变时会动画 改变视图的 透明度
    override var highlighted: Bool{
        
        didSet{
            
            //动画
            UIView.animateWithDuration(0.25) {
                
                //0 和 1  // 开始为0, 改变后将其改为不透明(相当于白到黑 -> 0...1)
                self.mask.alpha = CGFloat(self.highlighted)
            }
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
