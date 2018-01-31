//
//  MainHomeViewController.swift
//  DaMai
//
//  Created by 郭宏伟 on 2018/1/22.
//  Copyright © 2018年 eLab. All rights reserved.
//

import UIKit

let kBannerHeight: CGFloat = 150.0

class ChanelViewController: UIViewController {
    
    var initFirstCellRect: CGRect = .zero
    var firstCellIsUp: Bool = false
    var bannerRect: CGRect = .zero
    var layout: ChanelFlowLayout?
    var dataSourcesArray: [String] = ["1", "2", "2", "2", "2", "2", "2", "2", "2", "2"]

    lazy fileprivate var mainCollectionView: UICollectionView = {
        
        let layout = ChanelFlowLayout()
        self.layout = layout
        self.layout?.count = dataSourcesArray.count
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        collectionView.register(ChanelCollectionViewCell.self, forCellWithReuseIdentifier: "MainHomeCollectionViewCell")
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(mainCollectionView)
    }
    
}

extension ChanelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourcesArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainHomeCollectionViewCell", for: indexPath) as! ChanelCollectionViewCell
        cell.tag = indexPath.row
        cell.setIndex(index: indexPath.row)
        
        if indexPath.row == 0 {
            cell.imageViewCenter.image = nil
        } else {
            if indexPath.row == 1 {
                cell.revisePositionAtFirstCell()
            }
            cell.imageViewCenter.image = UIImage.init(named: "image_infoCollect1")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let offset = ceilf(Float(DRAG_INTERVAL) * Float(indexPath.row  - 1))
        if ceilf(Float(collectionView.contentOffset.y)) != offset {
            self.layout?.currentCount = indexPath.row
            collectionView.setContentOffset(CGPoint.init(x: 0, y: Int(offset)), animated: true)
        } else {
        }
        
        print("点击了第\(indexPath.row)个")

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: kScreenWidth, height: HEADER_HEIGHT)
        } else if (indexPath.row == 1) {
            return CGSize(width: kScreenWidth, height: CELL_CURRHEIGHT)
        } else {
            return CGSize(width: kScreenWidth, height: CELL_HEIGHT)
        }
    }
    
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.layout?.currentCount = 1
    }
    
    
    
}
















