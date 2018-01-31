//
//  MainHomeFlowLayout.swift
//  DaMai
//
//  Created by 郭宏伟 on 2018/1/22.
//  Copyright © 2018年 eLab. All rights reserved.
//

import UIKit

//let CELL_HEIGHT: CGFloat = kScreenWidth * 0.3
//let CELL_CURRHEIGHT: CGFloat = (kScreenWidth > kScreenHeight ? kScreenHeight : kScreenWidth) * 1.0
//let TITLE_HEIGHT: CGFloat = 24.0
//let IMAGEVIEW_ORIGIN_Y: CGFloat = 0.0
//let IMAGEVIEW_MOVE_DISTANCE: CGFloat = 215.0
//let DRAG_INTERVAL: CGFloat = CELL_CURRHEIGHT
//let RECT_RANGE: CGFloat = UIScreen.main.bounds.size.height + 300

class ChanelFlowLayout: UICollectionViewFlowLayout {
    var currentCount = 1
    var count = 0
    override var collectionViewContentSize: CGSize {
        return CGSize(width: kScreenWidth, height: DRAG_INTERVAL * CGFloat(count) + (kScreenHeight - DRAG_INTERVAL))
    }

    
    override init() {
        super.init()
        itemSize = CGSize(width: kScreenWidth, height: CELL_HEIGHT)
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
        let current_floor = floorf(Float((screen_y!) / DRAG_INTERVAL)) + 1
        let current_mod = fmodf(Float(screen_y!), Float(DRAG_INTERVAL))
        let percent = current_mod / Float(DRAG_INTERVAL)
        
        var correctRect: CGRect = .zero
        if current_floor == 0 || current_floor == 1 {
            correctRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: RECT_RANGE)
        } else {
            correctRect = CGRect(x: 0, y: CELL_HEIGHT * CGFloat(current_floor - 2), width: kScreenWidth, height: RECT_RANGE)
        }
        let original = super.layoutAttributesForElements(in: correctRect)
        let array = original
        
        let riseOfCurrentItem = CELL_CURRHEIGHT - DRAG_INTERVAL
        let incrementalHeightOfCurrentItem = CELL_CURRHEIGHT - CELL_HEIGHT
        let offsetOfNextItem = incrementalHeightOfCurrentItem - riseOfCurrentItem
        
        if screen_y! >= 0 {
            for attributes in array! {
                let row = attributes.indexPath.row
                if row < Int(current_floor) {
                    attributes.zIndex = 7
                    attributes.frame = CGRect(x: 0, y: DRAG_INTERVAL * CGFloat(row - 1), width: kScreenWidth, height: CELL_CURRHEIGHT)
                } else if (row == Int(current_floor)) {
                    attributes.zIndex = 8
                    attributes.frame = CGRect(x: 0, y: DRAG_INTERVAL * CGFloat(row - 1), width: kScreenWidth, height: CELL_CURRHEIGHT)
                } else if (row == Int(current_floor) + 1) {
                    attributes.zIndex = 9
                    let part = (CGFloat(current_floor) - 1) * offsetOfNextItem
                    let partOne = attributes.frame.origin.y + part - riseOfCurrentItem * CGFloat(percent)
                    let partTwo = CELL_HEIGHT + (CELL_CURRHEIGHT - CELL_HEIGHT) * CGFloat(percent)
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
                    let partOne = (current_floor - 1) * Float(offsetOfNextItem)
                    let originY = Float(attributes.frame.origin.y) + partOne + Float(offsetOfNextItem) * percent
                    attributes.frame = CGRect(x: 0, y: CGFloat(originY), width: kScreenWidth, height: CELL_HEIGHT)
                    
                }
                
                setImageViewOfItem(distance: (screen_y! - attributes.frame.origin.y)/kScreenHeight * IMAGEVIEW_MOVE_DISTANCE, indexPath: attributes.indexPath)
            }
        } else {
            
            for attributes in array! {
                if attributes.indexPath.row > 1 {
                    
                }
                setImageViewOfItem(distance: (screen_y! - attributes.frame.origin.y)/kScreenHeight * IMAGEVIEW_MOVE_DISTANCE, indexPath: attributes.indexPath)
            }
        }
        
        
        return array
        
    }
    
    func setImageViewOfItem(distance: CGFloat, indexPath: IndexPath) {
        let cell = collectionView?.cellForItem(at: indexPath) as? ChanelCollectionViewCell
//        cell?.imageViewCenter.frame = CGRect(x: 0, y: IMAGEVIEW_ORIGIN_Y + distance, width: kScreenWidth, height: (cell?.imageViewCenter.frame.size.height)!)
        cell?.contentView.layoutIfNeeded()
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var destination: CGPoint = .zero
        var positionY: CGFloat
        let screen_y: CGFloat = (self.collectionView?.contentOffset.y)!
        var cc: CGFloat
        var count: CGFloat
        
        if screen_y < 0 {
            return proposedContentOffset
        }
        
        if velocity.y == 0 {
            count = CGFloat(roundf(Float((proposedContentOffset.y)/DRAG_INTERVAL))) + 1
            self.currentCount = Int(count)
            if count == 0 {
                positionY = 0
            } else {
                positionY = (count - 1) * DRAG_INTERVAL
            }
        } else {
            if velocity.y > 1 {
                cc = 1
            } else if (velocity.y < -1) {
                cc = -1
            } else {
                cc = velocity.y
            }
            
            if velocity.y > 0 {
                count = CGFloat(ceilf(Float((screen_y + cc * DRAG_INTERVAL) / DRAG_INTERVAL)) + 1)
            } else {
                count = CGFloat(floorf(Float((screen_y + cc * DRAG_INTERVAL) / DRAG_INTERVAL)) + 1)
            }
            
            if count == 0 {
                positionY = 0
                currentCount = 1
            } else {
                if velocity.y > 0 {
                    count = CGFloat(self.currentCount + 1)
                    self.currentCount = self.currentCount + 1
                } else {
                    count = CGFloat(self.currentCount - 1)
                    self.currentCount = self.currentCount - 1
                }
                positionY = (count - 1) * DRAG_INTERVAL
            }
        }
        
        
        if positionY < 0 {
            positionY = 0
        }
        if positionY > ((self.collectionView?.contentSize.height)! - kScreenHeight) {
            positionY = ((self.collectionView?.contentSize.height)! - kScreenHeight)
            self.currentCount = self.currentCount - 1
            count = CGFloat(self.currentCount)
        }
        
        self.collectionView?.decelerationRate = 0.1
        destination = CGPoint(x: 0, y: positionY)
        return destination
    }
}


















































































































































































