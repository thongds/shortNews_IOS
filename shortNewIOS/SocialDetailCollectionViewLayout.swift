//
//  SocialDetailCollectionViewLayout.swift
//  shortNewIOS
//
//  Created by SSd on 12/17/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class SocialDetailCollectionViewAttributes : UICollectionViewLayoutAttributes {
    
    var contentTextHeight : CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! SocialDetailCollectionViewAttributes
        copy.contentTextHeight = contentTextHeight
        return copy
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? SocialDetailCollectionViewAttributes{
            if attributes.contentTextHeight == contentTextHeight{
                return super.isEqual(object)
            }
        }
        return false
    }
    
}


class SocialDetailCollectionViewLayout: UICollectionViewFlowLayout {
    var delegate : NewsLayoutDelegate!
    var space : CGFloat = 0
    fileprivate var cache = [NewsCollectionViewAttributes]()
    fileprivate var contentMaxHeight: CGFloat = 0
    fileprivate var width : CGFloat{
        get {
            return collectionView!.bounds.width
        }
    }
    override var collectionViewContentSize: CGSize{
        print("collectionViewContentSize \(CGSize(width: width, height: contentMaxHeight))")
        return CGSize(width: width, height: contentMaxHeight)
    }
    var yOffset: CGFloat = 0
    override func prepare() {
        print("prepare")
        if cache.isEmpty{
            let contentWidth = width-(UtilHelper.getMarginCell()*2)
            yOffset = space
            for item in 0..<collectionView!.numberOfItems(inSection: 0){
                let indexPath = IndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x: UtilHelper.getMarginCell(), y: yOffset, width: contentWidth, height: height)
                let attributes = NewsCollectionViewAttributes(forCellWith: indexPath)
                attributes.frame = frame
                attributes.contentHeight = height
                cache.append(attributes)
                contentMaxHeight = max(contentMaxHeight,frame.maxY)
                yOffset = yOffset + height + space
            }
            
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [NewsCollectionViewAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    func deleteCache(){
        cache.removeAll(keepingCapacity: false)
    }
    func resetMaxHeight(){
        contentMaxHeight = 0
    }

}
