//
//  MainHomeCollectionViewCell.swift
//  DaMai
//
//  Created by 郭宏伟 on 2018/1/22.
//  Copyright © 2018年 eLab. All rights reserved.
//

import UIKit

let CELL_HEIGHT: CGFloat = kScreenWidth * 0.3
let CELL_CURRHEIGHT: CGFloat = (kScreenWidth > kScreenHeight ? kScreenHeight : kScreenWidth) * 1.0
let TITLE_HEIGHT: CGFloat = 24.0
let IMAGEVIEW_ORIGIN_Y: CGFloat = 0.0
let IMAGEVIEW_MOVE_DISTANCE: CGFloat = 215.0
let DRAG_INTERVAL: CGFloat = CELL_CURRHEIGHT
let HEADER_HEIGHT: CGFloat = 0.0
let RECT_RANGE: CGFloat = UIScreen.main.bounds.size.height + CELL_HEIGHT * 2

@objc class ChanelCollectionViewCell: UICollectionViewCell {
    
    @objc lazy var imageViewCenter: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "image_infoCollect1"))
        imageView.frame = CGRect(x: 0, y: IMAGEVIEW_ORIGIN_Y - self.frame.origin.y / kScreenHeight * IMAGEVIEW_MOVE_DISTANCE, width: kScreenWidth, height: kScreenHeight)
//        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        clipsToBounds = true
        contentView.addSubview(imageViewCenter)
        imageViewCenter.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    func revisePositionAtFirstCell() {
        if self.tag == 1 {
            
        }
    }
    
    func setIndex(index: Int) {
        
    }
}






























