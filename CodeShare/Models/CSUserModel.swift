//
//  CSUserModel.swift
//  CodeShare
//
//  Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import YYModel


//用户数据模型
class CSUserModel: NSObject {

    
    var address = ""
    var avatar = ""
    var birthday = ""
    var gender = ""
    var nickname = ""
    var name = ""
    var phone = ""
    var email = ""
    var id: String?
    
    //用户单例
    static var SharedUser = CSUserModel()
    
    private override init() {  //单例,再构造方法中就对自身的属性赋值
        super.init()
        
        //取出沙盒数据,配置默认用户
        if let userInfo = NSUserDefaults.standardUserDefaults().objectForKey(String(CSUserModel)) {
            //利用字典来给self赋值
            self.yy_modelSetWithDictionary(userInfo as! Dictionary)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //判断用户是否登录
    class func isLogin() -> Bool{
        
        return SharedUser.id != nil
        
    }
    
    //根据登录后获取到的信息,配置用户数据
    class func login(with userInfo: [String: AnyObject]) {
        
        //kvc方法需要重写找不到key的函数
        //SharedUser.setValuesForKeysWithDictionary(userInfo)
        
        //用YYKit中的YYmodel,给模型类赋值
        SharedUser.yy_modelSetWithDictionary(userInfo)
    
        //存到沙盒目录下
        NSUserDefaults.standardUserDefaults().setObject(SharedUser.yy_modelToJSONObject(), forKey: String(CSUserModel))
        
        //同步
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    
    
    
}
