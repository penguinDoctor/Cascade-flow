//
//  WaterLayout.swift
//  Swift版瀑布流
//
//  Created by 飞翔 on 2019/11/4.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

class WaterLayout: UICollectionViewFlowLayout {
    
    ///列数
    var columCount = 0
    ///总条目个数
    var numberCount = 0
    ///内边距
    var edgeInset:UIEdgeInsets =  UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 40)
    ///每一列之间的间距
    var columnMargin = 10
    ///每一行之间的间距
    var rowMargin = 10
    ///存放所有的布局属性
    var attrsAry = [AnyObject]()
    ///存放所有列的当前高度的字典
    var columnHeights = [String:Any]()
    ///内容高度
    var contentHeight = 0
    
    override func prepare(){
        super.prepare()
        
        //初始化
        self.columCount = 3
        self.numberCount = self.collectionView!.numberOfItems(inSection: 0)
        
        ///清除所有列的高度
        self.columnHeights.removeAll()
        ///先给字典赋值
        for index in 0..<3 {
            self.columnHeights["\(index)"] = self.edgeInset.top
        }
        
        self.attrsAry.removeAll()
        
        for idx in 0..<self.numberCount {
            let indexPath = NSIndexPath.init(item:idx, section: 0)
            let attrs :UICollectionViewLayoutAttributes =  self.layoutAttributesForItem(at: indexPath as IndexPath) ?? UICollectionViewLayoutAttributes.init()
            self.attrsAry.append(attrs)
            
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attr = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        
        ///设置宽度
        let collectionW = self.collectionView!.frame.size.width
        let cellW = Int((collectionW - self.edgeInset.left - self.edgeInset.right - CGFloat((self.columCount - 1)*columnMargin)))/self.columCount
        let cellH = arc4random_uniform(40) + 80
        
        var minColumn = "0"
        self.columnHeights.map { (key,value) in
            
            print("key=\(key)","value=\(value)")
            if (value as! CGFloat) < self.columnHeights[minColumn] as! CGFloat {
                minColumn = key
            }
        }
        
        let itemX =  CGFloat(self.edgeInset.left) + CGFloat((columnMargin + cellW)*(Int(minColumn) ?? 0))
        let itemY = self.columnHeights[minColumn] as!CGFloat +  CGFloat (self.rowMargin)
        attr.frame = CGRect.init(x: itemX, y: itemY, width: CGFloat(cellW), height:CGFloat(cellH))
        
        self.columnHeights[minColumn] = itemY + CGFloat(cellH)
        return attr
        
    }
    
    override var collectionViewContentSize: CGSize{
        
        var maxColumn = "0"
        self.columnHeights.map {(key,value) in
            if value as! CGFloat > self.columnHeights[maxColumn] as! CGFloat{
                maxColumn = key
            }
        }
        
        let itemH = CGFloat(self.columnHeights[maxColumn] as! CGFloat) + CGFloat(self.edgeInset.bottom)
        
        return CGSize.init(width: 0, height: CGFloat(itemH))
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
           return self.attrsAry as! [UICollectionViewLayoutAttributes]
       }
       
    
}
