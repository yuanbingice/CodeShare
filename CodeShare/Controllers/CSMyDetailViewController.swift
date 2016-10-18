//
//  CSMyDetailViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/18.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import Alamofire
import swiftScan  //二维码扫描

//个人详细信息页面
class CSMyDetailViewController: CSTableViewController {

    
    var button = UIButton(type: .Custom)
    
    let cellInfos = [
        [
            "title": "昵称",
            "class": ""
        ],
        [
            "title": "性别",
            "class": ""
        ],
        [
            "title": "出生日期",
            "class": ""
        ],
        [
            "title": "所在地",
            "class": ""
        ],
        [
            "title": "扫一扫",
            "class": ""
        ],
        [
            "title": "我的二维码",
            "class": ""
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //头视图
        let headView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 140))
        tableView.tableHeaderView = headView
        
        button.setImage(UIImage(named: "用户头像"), forState: .Normal)
        headView.addSubview(button)
        
        button.snp_makeConstraints { (make) in
            
            make.center.equalTo(0)
            make.width.height.equalTo(100)
        }
        
        
        //更改用户图像
        button.jk_handleControlEvents(.TouchUpInside) { (sender) in
            
           let a
            = UIActionSheet(title: "选择头像来源", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择", "拍照")
            a.showInView(self.view)
        }
        
        
        //底部视图
        let footView = UIView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 100))
        let footBtn = UIButton(type: .Custom)
        footBtn.setTitle("退出登录", forState: .Normal)
        footBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        footBtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        footBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        footBtn.jk_setBackgroundColor(UIColor ( red: 0.9911, green: 0.5476, blue: 0.3325, alpha: 1.0 ), forState: .Normal)
        footView.addSubview(footBtn)
        
        
        footBtn.snp_makeConstraints { (make) in
            
            make.center.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(44)
            
        }
        
        //设置为脚视图
        self.tableView.tableFooterView = footView
        self.tableView.rowHeight = 44
        
        //组的头视图高度
        self.tableView.sectionHeaderHeight = 0  //组的头视图

        self.tableView.backgroundColor = UIColor ( red: 0.7943, green: 1.0, blue: 0.9744, alpha: 1.0 )
        
        self.tableView.registerClassOf(UITableViewCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension CSMyDetailViewController{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return cellInfos.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell()
        
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.text = self.cellInfos[indexPath.section]["title"]
        
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    //选中 cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //进到扫一扫页面
        if indexPath.section == 4{
            
            let scanVC = LBXScanViewController()
            //设置界面的样式
            scanVC.title = "二维码扫描"
            
            //扫描中的 动画图片
            scanVC.scanStyle?.animationImage = UIImage(named: "横线")
            //angle -> 角,,, 四角的颜色
            scanVC.scanStyle?.colorAngle = UIColor ( red: 0.442, green: 0.895, blue: 0.0994, alpha: 1.0 )
            
            scanVC.scanStyle?.photoframeAngleStyle = .Inner
            
            self.navigationController?.pushViewController(scanVC, animated: true)
            
            //处理结果
            
        }else if indexPath.section == 5{  //我的二维码页面
            
            let vc = CSMyRCodeViewController()
            
            self.navigationController?.pushViewController( vc, animated: true)
            
        }
        
    }
    
}

// MARK: 警告视图的代理
extension CSMyDetailViewController: UIActionSheetDelegate{
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        
        //警告 如果 buttonIndex != 0 就向下执行,否则return
        guard buttonIndex != 0 else{
            return
        }
        
        let imagePicker = UIImagePickerController()
        
        //点击警告视图的响应
        if buttonIndex == 1{  //从相册选择
            
            imagePicker.sourceType = .PhotoLibrary
            
        }else if buttonIndex == 2{
            
            imagePicker.sourceType = .Camera
        }
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
}

//MARK: 相册的点击事件
extension CSMyDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //完成选择
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        //取出编辑过后的图片
        let editedImage = info[UIImagePickerControllerEditedImage]
        //压缩图片转成data
        let iamgeData = UIImageJPEGRepresentation(editedImage as! UIImage, 0.9)
        
        //上传图片
        Alamofire.upload(.POST, QFAppBaseURL, multipartFormData: { (formData) in
            
            //拼接参数
            formData.appendBodyPart(data: "UserInfo.UpdateAvatar".dataUsingEncoding(NSUTF8StringEncoding)!, name: "service")
            
            formData.appendBodyPart(data: CSUserModel.SharedUser.id!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "uid")
            formData.appendBodyPart(data: iamgeData!, name: "avatar", fileName: "\(NSDate.init().timeIntervalSince1970).png", mimeType: "image/jpeg")
            
            }) { (encodingResult) in
                
                switch  (encodingResult) {
                    
                case .Success(let upload, _, _):
                    
                    upload.responseJSON({ (data, success) in
                        if success {  //上传成功
                            
                            self.button.setImage(editedImage as? UIImage, forState: .Normal)
                            //更改用户模型的属性
                            CSUserModel.SharedUser.avatar = "http://10.12.155.20/PhalApi/Public/\((data as! NSDictionary)["file_url"]!)"
                            
                            print(CSUserModel.SharedUser.avatar)
                        }else{
                            print(data)
                        }
                        
                        })
                case .Failure(let errorType):
                    
                    print(errorType)
                    
                }
        }
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


