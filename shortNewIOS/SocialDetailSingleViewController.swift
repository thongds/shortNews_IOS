//
//  SocialDetailSingleViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/19/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit
import Foundation
class SocialDetailSingleViewController: UIViewController {
    
    
    var imageLinks : [String]?{
        didSet{
            setupViews()
        }
    }
    let viewContentHolder = UIView()
    let closeBtm = UIImageView(image: UIImage(named: "close_btm"))
    
    var linkPostUrl : String?
    var spearateTag : String?
    var mPostType : Int?
    var isHaveImageContent : Bool = false
    var  slider : SliderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground()
        
    }
    
    func setupViews(){
        viewContentHolder.translatesAutoresizingMaskIntoConstraints = false
        closeBtm.translatesAutoresizingMaskIntoConstraints = false
        slider?.translatesAutoresizingMaskIntoConstraints = false
        viewContentHolder.isUserInteractionEnabled = true
        
        viewContentHolder.backgroundColor = UIColor.white
        viewContentHolder.layer.masksToBounds = true
        viewContentHolder.layer.cornerRadius = 9
        view.addSubview(viewContentHolder)
        view.addSubview(closeBtm)
        let viewContentHeight = view.frame.height*8/10
        let viewContentWidth =  view.frame.width * 9/10
        let xContentHolder =  view.frame.width/2-viewContentWidth/2
        let yContentHolder = view.frame.height/2-viewContentHeight/2 - ((view.frame.height-viewContentHeight)/4)
        let closeBtmHeight: CGFloat = 40
        let hostCloseHeight = view.frame.height - (yContentHolder + viewContentHeight)
        let yClosePos = hostCloseHeight/2 - closeBtmHeight/2
        let xClosePos = view.frame.width/2 - closeBtmHeight/2
        
        let views = ["view":view,"contentHolder": viewContentHolder,"closeBtm" : closeBtm,"slider" : slider]
        let viewMetrics =  ["xContentHolder" : xContentHolder,"yContentHolder" : yContentHolder,"viewContentHeight" : viewContentHeight,"viewContentWidth" : viewContentWidth,"closeBtmHeight" :closeBtmHeight,"yClosePos":yClosePos,"xClosePos" :xClosePos]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-yContentHolder-[contentHolder(viewContentHeight)]", options: [], metrics:viewMetrics, views: views ))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-xContentHolder-[contentHolder(viewContentWidth)]", options: [], metrics: viewMetrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[contentHolder]-yClosePos-[closeBtm(closeBtmHeight)]", options: [], metrics: viewMetrics, views: views))
         NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-xClosePos-[closeBtm(closeBtmHeight)]", options: [], metrics: viewMetrics, views: views))
        
        // contraint for containt
        // scrollView content
       
        
    }
    
    override func viewDidLayoutSubviews() {
        slider = SliderView(frame: CGRect(x: 0, y: 0, width: viewContentHolder.frame.width, height: viewContentHolder.frame.height) ,imageLinksArray : imageLinks!)
        slider?.imageLinks = imageLinks!
        viewContentHolder.addSubview(slider!)
        slider?.backgroundColor = UIColor.gray
    }
    
    func viewBackground(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 1.0
        blurEffectView.frame = view.frame
        view = blurEffectView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.closeView))
        closeBtm.isUserInteractionEnabled = true
        closeBtm.addGestureRecognizer(gesture)
     }
   
    
    func addView(){
   
        
        //-------------------------------end---------------------------------//
        
        //-------------------------------ScrollcontentView-------------------------//
       
       
       // scrollView content
//        scrollViewContent.frame = CGRect(x: 0, y: fanpageImage.frame.origin.y + fanpageImage.frame.height, width: viewContentHolder.frame.width, height: viewContentHolder.frame.height - (fanpageImage.frame.origin.y + fanpageImage.frame.height))
//        // status
//        status.numberOfLines = 0
//        status.frame = CGRect(x: 0, y: 0, width: scrollViewContent.frame.width, height: status.frame.height)
//        status.sizeToFit()
//        
//        print("status height \(status.frame.height)")
//        // image content
//        if let linkPostUrl = linkPostUrl, let spearateTag = spearateTag {
//            if let postType = mPostType{
//                if postType == 1{
//                    let  result = linkPostUrl.components(separatedBy: spearateTag)
//                    isHaveImageContent = result.count > 1
//                    slider = SliderView(frame: CGRect(x: 0, y: status.frame.origin.y + status.frame.height, width: viewContentHolder.frame.width, height: viewContentHolder.frame.height - (fanpageImage.frame.origin.y + fanpageImage.frame.height) ), imageLinkArray : result)
//                }
//            }
//            
//        }
//       
//      
//        if isHaveImageContent {
//            scrollViewContent.contentSize = CGSize(width: scrollViewContent.frame.width, height: (slider?.frame.height)! + status.frame.height )
//            scrollViewContent.addSubview(status)
//            scrollViewContent.addSubview(slider!)
//        }else{
//            scrollViewContent.addSubview(status)
//            scrollViewContent.contentSize = CGSize(width: scrollViewContent.frame.width, height: status.frame.height )
//        }
//        viewContentHolder.addSubview(scrollViewContent)
    }
    
    func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
