//
//  CSModel.swift
//  CodeShare
//
//  Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.
//

import Foundation
import YYKit

//视频模型
class CSMyVideoModel: NSObject {
    
    var title: String = ""
    var imageUrl = ""
    var videoUrl = ""
    var videoSize = ""
    
}

//我的文件模型
class CSMyFileModel: NSObject {
    
    var title: String = ""
    var imageUrl = ""
    var fileSize = ""
    var form = ""
    
}



//视频播放模型
class CSVideoListModel: NSObject{
    
    var videoList: [CSVideoModel]!
    var count: NSNumber = 0
    var total: NSNumber = 0
    var nextPageUrl = ""
    
    //利用YYModel中的方法,让得出的 "videoList"的值转化为 CSVideoModel模型 (因为开始读取videoList得到值会是 字典或数组 类型)
    class func modelContainerPropertyGenericClass() -> [String: AnyObject]?{
        
        return ["videoList": CSVideoModel.self]
    }
    
}


class CSVideoModel: NSObject{
    
    var id: NSNumber = 0
    var date: NSNumber = 0
    var idx: NSNumber = 0
    
    var title = ""
    var category = ""
    var duration = 0
    
    var playUrl = ""
    var playInfo: [CSPlayInfoModel]?
    var consumption: CSConsumptionModel?
    
    var promotion = ""
    var waterMarks = ""
    
    //利用YYModel中的方法,让得出的 "playInfo"的值转化为 CSPlayInfoModel模型 (因为开始读取playInfo得到值会是 字典或数组 类型)
    class func modelContainerPropertyGenericClass() -> [String: AnyObject]?{
        
        return ["playInfo": CSPlayInfoModel.self]
    }
    
    
}

class CSPlayInfoModel: NSObject {
    
    var height: NSNumber = 0
    var width: NSNumber = 0
    var name = ""
    
    var type = ""
    var url = ""
}

class CSConsumptionModel: NSObject {
    
    var collectionCount: NSNumber = 0
    var shareCount: NSNumber = 0
    var playCount: NSNumber = 0
    var replyCount: NSNumber = 0
}



