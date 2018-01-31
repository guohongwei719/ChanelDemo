//
//  MainHomeCollectionViewCell.swift
//  DaMai
//
//  Created by 郭宏伟 on 2018/1/22.
//  Copyright © 2018年 eLab. All rights reserved.
//

import UIKit

let kNormalCellHeight: CGFloat = kScreenWidth * 0.3
let kBigCellHeight: CGFloat = kScreenWidth * 1.0
let kRectRange: CGFloat = UIScreen.main.bounds.size.height + kNormalCellHeight * 2

@objc class ChanelCollectionViewCell: UICollectionViewCell {
    
    @objc lazy var imageViewCenter: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "image_infoCollect1"))
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






























