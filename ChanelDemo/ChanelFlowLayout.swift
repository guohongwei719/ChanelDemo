//
//  MainHomeFlowLayout.swift
//  DaMai
//
//  Created by 郭宏伟 on 2018/1/22.
//  Copyright © 2018年 eLab. All rights reserved.
//

import UIKit

class ChanelFlowLayout: UICollectionViewFlowLayout {
    var currentCount = 1
    var count = 0
    override var collectionViewContentSize: CGSize {
        return CGSize(width: kScreenWidth, height: kBigCellHeight * CGFloat(count) + (kScreenHeight - kBigCellHeight))
    }
    
    override init() {
        super.init()
        itemSize = CGSize(width: kScreenWidth, height: kNormalCellHeight)
        scrollDirection = .vertical
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ChanelFlowLayout {
    override func prepare() {
        super.prepare()
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let screen_y = collectionView?.contentOffset.y
        let current_floor = floorf(Float((screen_y!) / kBigCellHeight)) + 1
        let current_mod = fmodf(Float(screen_y!), Float(kBigCellHeight))
        let percent = current_mod / Float(kBigCellHeight)
        
        var correctRect: CGRect = .zero
        if current_floor == 0 || current_floor == 1 {
            correctRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kRectRange)
        } else {
            correctRect = CGRect(x: 0, y: kNormalCellHeight * CGFloat(current_floor - 2), width: kScreenWidth, height: kRectRange)
        }
        let original = super.layoutAttributesForElements(in: correctRect)
        let array = original
        
        let incrementalHeightOfCurrentItem = kBigCellHeight - kNormalCellHeight
        
        if screen_y! >= 0 {
            for attributes in array! {
                let row = attributes.indexPath.row
                if row < Int(current_floor) {
                    attributes.zIndex = 7
                    attributes.frame = CGRect(x: 0, y: kBigCellHeight * CGFloat(row - 1), width: kScreenWidth, height: kBigCellHeight)
                } else if (row == Int(current_floor)) {
                    attributes.zIndex = 8
                    attributes.frame = CGRect(x: 0, y: kBigCellHeight * CGFloat(row - 1), width: kScreenWidth, height: kBigCellHeight)
                } else if (row == Int(current_floor) + 1) {
                    attributes.zIndex = 9
                    let part = (CGFloat(current_floor) - 1) * incrementalHeightOfCurrentItem
                    let partOne = attributes.frame.origin.y + part
                    let partTwo = kNormalCellHeight + (kBigCellHeight - kNormalCellHeight) * CGFloat(percent)
                    attributes.frame = CGRect(x: 0, y: partOne, width: kScreenWidth, height: partTwo)
                    
                } else {
                    if row == Int(current_floor) + 2 {
                        attributes.zIndex = 6
                    } else if (row == Int(current_floor) + 3) {
                        attributes.zIndex = 5
                    } else if (row == Int(current_floor) + 4) {
                        attributes.zIndex = 4
                    } else if (row == Int(current_floor) + 5) {
                        attributes.zIndex = 3
                    } else if (row == Int(current_floor) + 6) {
                        attributes.zIndex = 2
                    } else if (row == Int(current_floor) + 7) {
                        attributes.zIndex = 1
                    } else {
                        attributes.zIndex = 0
                    }
                    let partOne = (current_floor - 1) * Float(incrementalHeightOfCurrentItem)
                    let originY = Float(attributes.frame.origin.y) + partOne + Float(incrementalHeightOfCurrentItem) * percent
                    attributes.frame = CGRect(x: 0, y: CGFloat(originY), width: kScreenWidth, height: kNormalCellHeight)
                    
                }

            }
        }
        
        return array
        
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var destinationPoint: CGPoint = .zero
        var destinationPointY: CGFloat
        let contentOffsetY: CGFloat = (self.collectionView?.contentOffset.y)!
        var realVelocityY: CGFloat
        var cellLocation: CGFloat
        
        if contentOffsetY < 0 {
            return proposedContentOffset
        }
        
        if velocity.y == 0 {
            cellLocation = CGFloat(roundf(Float((proposedContentOffset.y)/kBigCellHeight))) + 1
            self.currentCount = Int(cellLocation)
            if cellLocation == 0 {
                destinationPointY = 0
            } else {
                destinationPointY = (cellLocation - 1) * kBigCellHeight
            }
        } else {
            if velocity.y > 1 {
                realVelocityY = 1
            } else if (velocity.y < -1) {
                realVelocityY = -1
            } else {
                realVelocityY = velocity.y
            }
            
            if velocity.y > 0 {
                cellLocation = CGFloat(ceilf(Float((contentOffsetY + realVelocityY * kBigCellHeight) / kBigCellHeight)) + 1)
            } else {
                cellLocation = CGFloat(floorf(Float((contentOffsetY + realVelocityY * kBigCellHeight) / kBigCellHeight)) + 1)
            }
            
            if cellLocation == 0 {
                destinationPointY = 0
                currentCount = 1
            } else {
                if velocity.y > 0 {
                    cellLocation = CGFloat(self.currentCount + 1)
                    self.currentCount = self.currentCount + 1
                } else {
                    cellLocation = CGFloat(self.currentCount - 1)
                    self.currentCount = self.currentCount - 1
                }
                destinationPointY = (cellLocation - 1) * kBigCellHeight
            }
        }
        if destinationPointY < 0 {
            destinationPointY = 0
        }
        if destinationPointY > ((self.collectionView?.contentSize.height)! - kScreenHeight) {
            destinationPointY = ((self.collectionView?.contentSize.height)! - kScreenHeight)
            self.currentCount = self.currentCount - 1
            cellLocation = CGFloat(self.currentCount)
        }
        
        self.collectionView?.decelerationRate = 0.1
        destinationPoint = CGPoint(x: 0, y: destinationPointY)
        return destinationPoint
    }
}


















































































































































































