//
//  ViewController.swift
//  Swift版瀑布流
//
//  Created by 飞翔 on 2019/11/3.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    static let cellID = "cellID"
    lazy var collectionView:UICollectionView = {
        
        let layout = WaterLayout()
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout:layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ViewController.cellID)
        
        return collectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100;
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.cellID, for: indexPath)
        
        let randomR = CGFloat(arc4random_uniform(255))/255.0
        let randomG = CGFloat(arc4random_uniform(255))/255.0
        let randomB = CGFloat(arc4random_uniform(255))/255.0
        
        cell.backgroundColor = UIColor.init(red: CGFloat(randomR), green: CGFloat(randomG), blue: CGFloat(randomB), alpha: 1)
        return cell
    }
    
}

