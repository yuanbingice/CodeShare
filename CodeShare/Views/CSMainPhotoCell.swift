// CSMainPhotoCell.swift  CodeShare  Created by ice on 2016/10/17.
//  Copyright © 2016年 k. All rights reserved.

import UIKit
import WPAttributedMarkup   //简单的图文混排 等等
import SDCycleScrollView
import IDMPhotoBrowser   //照片浏览器(browser),大图浏览

//主页的 图片cell
class CSMainPhotoCell: UITableViewCell {
    
    var pageLabel = UILabel()
    let imageGroup = ["image01", "image02", "image03"] //滚动图片的数组资源
    
    //注册时会调用这个方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor ( red: 0.9085, green: 0.9154, blue: 0.9579, alpha: 1.0 )
        
        // 顶部个人信息部分
        let topView = UIView()
        topView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            
            make.left.top.right.equalTo(0)
            make.height.equalTo(56)
        }
        
        // 头像
        let headImage = UIImageView(image: UIImage(named: "首页头像"))
        topView.addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            
            make.left.equalTo(8)
            make.centerY.equalTo(0)
            make.width.height.equalTo(36)
        }
        // 名称
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(15)
        nameLabel.textColor = UIColor.darkGrayColor()
        nameLabel.text = "FateAsuka"
        topView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(headImage.snp_right).offset(5)
            make.top.equalTo(headImage)
        }
        
        // 时间
        let timeLabel = UILabel()
        topView.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImage)
        }
        
        //MARK: 利用第三方库设置一些属性
        
        //以 html 的语法来设置 label 中内容的样式
        //样式是以字典的形式设置, key是随意写的,只需要用 key 价格内容包含其阿里就可以了
        let style: [NSString: AnyObject] = [
            "clock": UIImage(named: "时间图标")!,
            "fontColor": UIColor.lightGrayColor(),
            "fontSize": UIFont.systemFontOfSize(13)
        ]
        
        let timeStr: NSString = "<clock> </clock><fontColor><fontSize>一天</fontSize></fontColor>"
        //将图片, 文字的颜色,大小 设置赋值给 timeLabel 的属性文字
        timeLabel.attributedText = timeStr.attributedStringWithStyleBook(style)
        
        
        //添加好友
        let addFriend = UIButton(type: .Custom)
        addFriend.setImage(UIImage(named: "加好友图标"), forState: .Normal)
        topView.addSubview(addFriend)
        addFriend.snp_makeConstraints { (make) in
            
            make.right.equalTo(-8)
            make.centerY.equalTo(0)
            make.width.height.equalTo(18)
        }
        
        //中间的滚动展示图片视图(利用的是循环滚动视图)
        let photoBrowser =  SDCycleScrollView()
        photoBrowser.localizationImageNamesGroup = ["image01", "image02", "image03"]
        //本地占位图
        photoBrowser.placeholderImage = UIImage(named: "image01")
        
        //不显示
        photoBrowser.showPageControl = false
        //自动滚动
        photoBrowser.autoScroll = false
        photoBrowser.delegate = self  //代理,管理滑动后的事件,和点击后的事件
        
        self.contentView.addSubview(photoBrowser)
        photoBrowser.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(headImage.snp_bottom).offset(8)
            make.height.equalTo(170)
        }
        
        //右上角页码
        pageLabel = UILabel()
        pageLabel.backgroundColor = UIColor(red: 0.667, green: 0.667, blue: 0.6667, alpha: 0.6)
        pageLabel.textColor = UIColor.lightGrayColor()
        pageLabel.font = UIFont.systemFontOfSize(14)
        pageLabel.text = "1/3"
        pageLabel.layer.cornerRadius = 12
        pageLabel.layer.masksToBounds = true
        pageLabel.textAlignment = .Center
        photoBrowser.addSubview(pageLabel)
        
        pageLabel.snp_makeConstraints { (make) in
            
            make.right.equalTo(-8)
            make.top.equalTo(8)
            make.width.height.equalTo(24)
            
        }
        
        //图片定位
        let locateLabel = UILabel()
        locateLabel.backgroundColor = UIColor(red: 0.667, green: 0.667, blue: 0.6667, alpha: 0.6)
        
        let locateStyle: [NSString: AnyObject] = [
            
            "locate": UIImage(named: "地理图标")!,
            "font": UIFont.systemFontOfSize(13),
            "color": UIColor.lightTextColor()
        ]
        
        let locateStr: NSString = "<locate> </locate><font><color>西安市雁塔区高新四路永安大厦四楼</color></font>"
        locateLabel.attributedText = locateStr.attributedStringWithStyleBook(locateStyle)
        
        photoBrowser.addSubview(locateLabel)
        locateLabel.snp_makeConstraints { (make) in
            
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(24)
        }
        
        
        let tagButton = UIButton(type: .Custom)
        tagButton.setTitle("#我喜欢今天的拍摄", forState: .Normal)
        tagButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        tagButton.jk_setBackgroundColor(UIColor.clearColor(), forState: .Normal)
        tagButton.setTitleColor(UIColor ( red: 0.445, green: 1.0, blue: 0.2338, alpha: 1.0 ), forState: .Normal)
        tagButton.titleEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        tagButton.layer.cornerRadius = 4
        tagButton.layer.masksToBounds = true
        self.contentView.addSubview(tagButton)
        tagButton.snp_makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(photoBrowser.snp_bottom).offset(4)
            make.height.equalTo(22)
        }
        
        let titles = ["分享", "感兴趣", "下载", "评论"]
        var lastView: UIButton? = nil  //中间变量
        
        for title in titles{
            
            let button = UIButton(type: .Custom) //默认左侧图片,右侧文字
            button.setTitle(title, forState: .Normal)
            button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            button.setImage(UIImage(named: "\(title)图标"), forState: .Normal)
           // button.imageEdgeInsets = UIEdgeInsetsMake(0, 4, 0, -4) //可以移动图片的位置,调整按钮上面图片 和 文字的位置
            
            button.titleLabel?.font = UIFont.systemFontOfSize(13)
            self.contentView.addSubview(button)
            
            button.snp_makeConstraints(closure: { (make) in
                
                make.left.equalTo(lastView == nil ? self.contentView.snp_left : (lastView?.snp_right)!)
                make.width.equalTo(self.contentView).dividedBy(4)  //除
                make.height.equalTo(24)
                make.top.equalTo(tagButton.snp_bottom).offset(4)
                
            })
            lastView = button
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


//MARK: 循环滚动视图的代理
extension CSMainPhotoCell: SDCycleScrollViewDelegate{
    
    /** 点击图片回调 */
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int){
        
        //跳到大图浏览(利用的是大图浏览控制器)
        var photos = [IDMPhoto]()
        
        for imageName in imageGroup{
            let image = IDMPhoto(image: UIImage(named: imageName))
            photos.append(image)
        }
        
        let photoBrowser = IDMPhotoBrowser(photos: photos, animatedFromView: cycleScrollView)
        //初始是第几页
        photoBrowser.setInitialPageIndex(UInt(index))
        photoBrowser.displayToolbar = true
        photoBrowser.displayCounterLabel = true
        
        //获取view自己所在的 视图控制器  展示新的页面
        self.jk_viewController.presentViewController(photoBrowser, animated: true, completion: nil)
        
    }
    
    /** 图片滚动回调 */
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didScrollToIndex index: Int){
    
        //改变展示的页码
        pageLabel.text = "\(index+1)/\(imageGroup.count)"
    }

    
}

