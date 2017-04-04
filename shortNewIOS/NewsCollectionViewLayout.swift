//
//  NewsCollectionViewLayout.swift
//  shortNewIOS
//
//  Created by SSd on 12/4/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

protocol NewsLayoutDelegate {
    func collectionView(_ collectionView : UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class NewsCollectionViewAttributes : UICollectionViewLayoutAttributes {

    var contentHeight : CGFloat = 0
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! NewsCollectionViewAttributes
        copy.contentHeight = contentHeight
        return copy
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? NewsCollectionViewAttributes{
            if attributes.contentHeight == contentHeight{
                return super.isEqual(object)
            }
        }
        return false
    }
    
}

class NewsCollectionViewLayout: UICollectionViewFlowLayout {

    var delegate : NewsLayoutDelegate!
    var space : CGFloat = 0
    var cached : Bool = false
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
        if !cached{
            let contentWidth = width-(UtilHelper.getMarginCell()*2)
            let headerHeight : CGFloat = 60
            let headerAttribute = NewsCollectionViewAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath(item: 0, section: 0))
            headerAttribute.frame = CGRect(x: 0, y: 0, width: contentWidth, height: headerHeight)
            cache.append(headerAttribute)
            yOffset = space + headerHeight
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
                cached = true
            }
            
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [NewsCollectionViewAttributes]()
        for attributes in cache {
            layoutAttributes.append(attributes)
//            if attributes.frame.intersects(rect) {
//                layoutAttributes.append(attributes)
//            }
        }
        return layoutAttributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    func deleteCache(){
        cache.removeAll(keepingCapacity: false)
        cached = false
    }
    func resetMaxHeight(){
        contentMaxHeight = 0
    }
}
