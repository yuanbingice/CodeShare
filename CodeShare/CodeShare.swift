//
//  CodeShare.swift
//  CodeShare
//
//  Created by ice on 2016/10/12.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
//网络请求的基地址

//一般项目都会有一个测试地址,所以我们一般会根据是否是 DEBUG 模式改变 baseUrl

#if true
    
let QFAppBaseURL = "http://10.12.155.20/PhalApi/Public/CodeShare/"

#else
    
public let QFAppBaseURL = "http://www.1000phone.tk/"
    
#endif



//图片资源的基地址
public let QFResourceBaseUrl = "http://www.1000phone.ml/upload/QFApi"

//短信发送的SDK 的appKey 和 appSecret
public let MobApp = "142d07ce785cb"

public let MobSecret = "adecbf154b1728cb450ab56c0344e988";
