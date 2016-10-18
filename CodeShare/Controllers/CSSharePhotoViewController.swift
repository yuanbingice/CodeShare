//
//  CSSharePhotoViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/18.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import UzysAssetsPickerController  //选择图片
import IDMPhotoBrowser   //大图浏览

//图片分享页面
class CSSharePhotoViewController: CSScrollerViewController {

    var photoList: UICollectionView! //下方的图片列表
    
    var cellModles = [UIImage(named: "加好友图标")]  //添加的图片数组
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //分享按钮
        let shareBtn = UIButton(type: .Custom)
        shareBtn.setTitle("分享", forState: .Normal)
        shareBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        shareBtn.jk_setBackgroundColor(UIColor.init(red: 0.5618, green: 0.9616, blue: 0.3098, alpha: 1.0), forState: .Normal)
        shareBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Highlighted)
        shareBtn.layer.cornerRadius = 4.0
        shareBtn.layer.masksToBounds = true
//        shareBtn.snp_makeConstraints { (make) in
//            
//            make.width.equalTo(60)
//            make.height.equalTo(30)
//        }

        shareBtn.frame = CGRectMake(0, 0, 56, 24)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareBtn)
        
        
        //文本框
        let textView = UITextView()
        textView.font = UIFont.systemFontOfSize(15)
        self.contentView.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            
            make.left.top.equalTo(8)
            make.centerX.equalTo(0)
            make.height.equalTo(100)
        }
        
        
        //图片列表
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake((self.view.bounds.width-30) / 4.0, (self.view.bounds.width-30) / 4.0)
        flowLayout.minimumLineSpacing = 6
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6)
        
        photoList = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        
        self.contentView.addSubview(photoList)
        photoList.snp_makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(textView.snp_bottom)
        }
        
        photoList.backgroundColor = UIColor ( red: 0.9994, green: 0.9738, blue: 0.9611, alpha: 1.0 )
        photoList.registerClassOf(CSMyPhotoCollectionViewCell)
        
        photoList.delegate = self
        photoList.dataSource = self
        
        
        self.scrrollerView.backgroundColor = UIColor ( red: 0.9398, green: 0.9398, blue: 0.9398, alpha: 1.0 )
        self.contentView.backgroundColor = UIColor ( red: 0.9398, green: 0.9398, blue: 0.9398, alpha: 1.0 )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

// MARK: 集合视图代理
extension CSSharePhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellModles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: CSMyPhotoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.imageView.image = cellModles[indexPath.item]
        
        return cell
    }
    
    
    //选中
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.item == self.cellModles.count - 1{
            
            //如果点击的是加号, 选选择图片
            let pickerVC = UzysAssetsPickerController()
            
            //最多可以选择几个图片
            pickerVC.maximumNumberOfSelectionPhoto = 9
            
            //选择视频的个数
            pickerVC.maximumNumberOfSelectionVideo = 0
            
            //设置样式和代理
            UzysAppearanceConfig.sharedConfig().finishSelectionButtonColor = UIColor ( red: 0.9885, green: 0.4129, blue: 0.9553, alpha: 1.0 )
        
            pickerVC.delegate = self
            
            self.presentViewController(pickerVC, animated: true, completion: nil)
            
        }else{ //如果点击的是图片,浏览图片
            
            //创建大图浏览视图控制器 所 展示的图片数组
            var photoGroup: [IDMPhoto] = []
            
            for image in self.cellModles{
                
                //如果是是最后一张 ➕
                if image == self.cellModles.last!{
                    break
                }
                
                let photo = IDMPhoto(image: image!)
                photoGroup.append(photo)
            }
            
            //创建视图控制器
             let photoBrowser = IDMPhotoBrowser(photos: photoGroup, animatedFromView: collectionView.cellForItemAtIndexPath(indexPath))
            //从哪张张图片显示
             photoBrowser.setInitialPageIndex(UInt(indexPath.item))
            
            //展示大图浏览的视图控制器(第三库封装)
            self.presentViewController(photoBrowser, animated: true, completion: nil)
        
        }
        
        
    }
    
}

//MARK: UzysAssetsPickerControllerDelegate, 选中图片的代理
extension CSSharePhotoViewController: UzysAssetsPickerControllerDelegate{
    
    //成功选中某些图片
    func uzysAssetsPickerController(picker: UzysAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        
        //取出选中的图片放进模型数组中
        for ass in assets{
            
            let representation = ass as! ALAsset
            
            if (representation.valueForProperty(ALAssetPropertyType) != nil){
                
                let fullImage = representation.defaultRepresentation().fullResolutionImage().takeUnretainedValue()
                
                //得到选中的照片
                let selectImage = UIImage(CGImage: fullImage)
                
                //需要插入,放在默认图片(➕)之前
                self.cellModles.insert(selectImage, atIndex: 0)
            }
        }
        
        //刷新collectionView
        self.photoList.reloadData()
    
    }
    
    //取消了选中
    func uzysAssetsPickerControllerDidCancel(picker: UzysAssetsPickerController!) {
        
    }
    
    //超出了选择的个数
    func uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection(picker: UzysAssetsPickerController!) {
        
    }

    
}
