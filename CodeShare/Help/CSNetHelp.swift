// CSNetHelp.swift CodeShare
//  Created by ice on 2016/10/13.
//  Copyright © 2016年 k. All rights reserved.


import UIKit
import Alamofire

//封装一些简单方法
public class CSNetHelp: NSObject {

    
    //可以直接给参数赋值,将参数写成固定的  //Alamofire.Method,前面的Alamofire用于区分
    //在Alamofire的基础上封装一个更简单的方法,可以在参数中直接将值写定
    
    public class  func request(   //该方法封装后,只会传入parameters一个参数
        method: Alamofire.Method = .POST,
        URLString: String = QFAppBaseURL,
        parameters: [String: String],
        headers: [String: String]? = nil
    
        ) -> Alamofire.Request{
        
        
        return Alamofire.request(method, URLString, parameters: parameters, encoding: .URL, headers: headers)
    }
    
}

extension Request{
    
    //封装网络回调方法,可以方便的统一处理错误,在具体数据
    func responseJSON(
        
        comletionHandle: (data: AnyObject, success: Bool) -> Void
        ) -> Self {
        
        //返回的是Alamofire中的方法,只不过在该方法中操作后  在执行参数闭包()
        return responseJSON(completionHandler: { (response) in
            
            let result = response.result
            
            //声明需要返回的两个参数
            var success = false   //开始为false 只有当操作成功后才将其值置为 true
            var data: AnyObject = "网络有问题,请重试"
            
            //
            if result.isSuccess{
                //server 服务器
                let serverData = result.value as! NSDictionary
                //print(serverData)
                
                //取出服务器的返回码
                let serverRet = serverData["ret"] as! Int
                
                if serverRet != 200{ //请求出现问题
                    
                    data = serverData["data"]!
                    
                }else{//请求成功
                    
                    let retValue = serverData["data"] as! Dictionary<String, AnyObject>
                    
                    //取回操作返回码
                    let retCode = retValue["code"] as! Int
                    
                    print(retValue)
                    print(retCode)
                    
                    if retCode == 0{  //操作成功
                        
                        success = true
                        data = retValue["data"]!  //成功后为个人信息
                        print(data)
                        
                    }else{
                        
                        print("msg为空") //登录和注册的都为空
                        
                    }
                    
                }
                
            }else{
                
                data = (result.error?.localizedDescription)!
                
            }
           
            //调用传入的回调闭包,成功就方法请求到的数据,,, 失败就返回失败的原因
            comletionHandle(data: data, success: success)
        })
        
    }
    
}

