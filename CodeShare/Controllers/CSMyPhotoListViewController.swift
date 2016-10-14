//
//  CSMyPhotoListViewController.swift
//  CodeShare
//
//  Created by ice on 2016/10/14.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//我的图片列表控制器

class CSMyPhotoListViewController: ViewController {

    
    var collectionView: UICollectionView!
    
    //设置集合视图需要的
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var cellModel = [
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        "图片",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        
        self.view.addSubview(collectionView)
        
        collectionView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
        }
        
        //集合视图中cell的大小
        flowLayout.itemSize = CGSizeMake(60, 60)
        //设置边距
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        //flowLayout.scrollDirection = .Vertical   //滑动方向,默认就为垂直
        
        flowLayout.minimumLineSpacing = 10  //最小行间距
        flowLayout.minimumInteritemSpacing = 10  //最小列间距
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //注册cell(不是xib)
        
        collectionView.registerClassOf(CSMyPhotoCollectionViewCell)
        
        self.view.backgroundColor = UIColor ( red: 0.8596, green: 0.8646, blue: 0.8603, alpha: 1.0 )
        collectionView.backgroundColor = UIColor ( red: 0.9432, green: 0.9367, blue: 0.9495, alpha: 1.0 )
        
        //集合视图边缘
        collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

//MARK: 集合视图的代理
extension  CSMyPhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        //利用泛型来获取  所以必须制定cell的类型
        let cell: CSMyPhotoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //反选
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    
    
}
