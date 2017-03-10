//
//  SliderView.swift
//  shortNewIOS
//
//  Created by SSd on 12/19/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class SliderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var imageLinks = [String]()
    var imageWidth : CGFloat?
    let scrollView = UIScrollView()
    let scrollViewIndicator = ScrollViewIndicator()
    var scIdViewHolder = UIView()
    let scIdViewHolderHeightConstant : CGFloat = 70
    var scIdViewHolderHeightRiote : CGFloat = 0
    
    init(frame: CGRect,imageLinksArray : [String]) {
        super.init(frame: frame)
        imageLinks = imageLinksArray
        addView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func addView(){
        print("frame \(frame)")
        scIdViewHolderHeightRiote = frame.height * 1/10
        var scIdViewHolderHeight : CGFloat = 0
//        if imageLinks.count > 2{
//            scIdViewHolderHeight = scIdViewHolderHeightConstant + scIdViewHolderHeightRiote
//            print("scIdViewHolderHeight \(scIdViewHolderHeight)")
//        }
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - scIdViewHolderHeight)
        scrollView.backgroundColor = UIColor.black
        
        scIdViewHolder.frame = CGRect(x: 0, y: scrollView.frame.origin.y + scrollView.frame.height + 9, width: scrollView.frame.width, height: scIdViewHolderHeight)
        scIdViewHolder.backgroundColor = UIColor.red
        scrollIdViewBackground()
        scrollViewIndicator.frame = CGRect(x: 0, y: 0, width: scIdViewHolder.frame.width, height: scIdViewHolder.frame.height - 9*2)
        scrollViewIndicator.backgroundColor = UIColor.red
        scrollViewIndicator.showsHorizontalScrollIndicator = false
        scrollViewIndicator.setDelegate(self)
        scrollView.showsHorizontalScrollIndicator = false
        var numberImage : Int = 0
        
        for (index,link) in (imageLinks.enumerated()) {
        
            if !link.isEmpty{
                numberImage = numberImage + 1
                let imageView : CustomImage = {
                    let imageView = CustomImage()
                    imageView.image = UIImage(named: "taylor_swift_bad_blood")
                    imageView.contentMode = .scaleAspectFit
                    return imageView
                }()
                imageView.loadImageForUrl(link)
                imageView.frame = CGRect(x: CGFloat(index) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
                scrollView.addSubview(imageView)
                
            }
        }
        
        //-------------------------------- scrollViewIndicator-config-------------------------------------
        imageWidth = scrollViewIndicator.frame.height
        print("imageWidth\(imageWidth)")
        let contentWidth = CGFloat(numberImage)*imageWidth!
        print(numberImage)
        if numberImage <= 3 {
            scrollViewIndicator.contentSize.width = contentWidth
            scrollViewIndicator.frame.size.width = contentWidth
            scrollViewIndicator.frame.origin.x = scrollView.frame.width/2 - scrollViewIndicator.contentSize.width/2
        }else{
            scrollViewIndicator.contentSize.width = contentWidth
            print("content offset \(scrollViewIndicator.contentOffset)")
            scrollViewIndicator.frame.size.width = imageWidth!
            scrollViewIndicator.frame.origin.x = 0
            scrollViewIndicator.isPagingEnabled = true
            scrollViewIndicator.clipsToBounds = false
        }
        for (index,link) in (imageLinks.enumerated()){
            if !link.isEmpty {
                let imageViewIndicator : CustomImageScrollviewCell = {
                    let imageView = CustomImageScrollviewCell(frame: CGRect.zero,scrollView: scrollViewIndicator)
                    imageView.image = UIImage(named: "taylor_swift_bad_blood")
                    return imageView
                }()
                imageViewIndicator.loadImageForUrl(link)
                imageViewIndicator.frame = CGRect(x: CGFloat(index) * imageWidth!, y: 0, width: imageWidth!, height: imageWidth!)
                let imageMask = UIView()
                imageMask.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
                imageMask.frame = CGRect(x: 0, y: 0, width: imageWidth!, height: imageWidth!)
                if index != 0                                                                                                                                               {
                    imageViewIndicator.addSubview(imageMask)
                }
                scrollViewIndicator.addSubview(imageViewIndicator)
            }
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(numberImage) * scrollView.frame.width, height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        addSubview(scrollView)
//        if imageLinks.count > 2{
//            addSubview(scIdViewHolder)
//            scIdViewHolder.addSubview(scrollViewIndicator)
//        }
    }
    func scrollIdViewBackground(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 1.0
        blurEffectView.frame = scIdViewHolder.frame
        scIdViewHolder = blurEffectView
    }
}
extension SliderView : ScrollViewIndicatorDelegate {
    
    func scrollTouch (_ point : CGPoint){
//        if let imageWidth = imageWidth {
//            if point.x > imageWidth {
//                //scrollViewIndicator.contentOffset.x = imageWidth
//                scrollViewIndicator.frame = CGRect(x: imageWidth, y: 0, width: scIdViewHolder.frame.width, height: scIdViewHolder.frame.height)
//            
//            }else{
//                scrollViewIndicator.frame.origin.x = 0
//            }
//            print("new content offset \(scrollViewIndicator.contentOffset)")
//            
//        }
    }
}










