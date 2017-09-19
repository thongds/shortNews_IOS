//
//  LoadingPage.swift
//  HITRUM
//
//  Created by SSd on 5/29/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol LoadDataDelegate {
    func clickLoadData()
}

class LoadingPage: UIView {
    var activityIndicatorView : NVActivityIndicatorView?
    var loadingPageDelegate : LoadDataDelegate?
    var reloadImage = UIImageView(image: #imageLiteral(resourceName: "reload"))
    var isLoading : Bool?
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicatorView = NVActivityIndicatorView(frame: frame)
        activityIndicatorView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        activityIndicatorView?.type = .ballRotateChase
        activityIndicatorView?.color = UIColor.green
        reloadImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        reloadImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.loadData))
        reloadImage.addGestureRecognizer(tap)
        self.addSubview(reloadImage)
        self.addSubview(activityIndicatorView!)
        isLoadingData(isLoading: true)
    }
    
    func isLoadingData(isLoading : Bool){
        if(isLoading){
            reloadImage.isHidden = true
            activityIndicatorView?.isHidden = false
            activityIndicatorView?.startAnimating()
        }else{
            reloadImage.isHidden = false
            activityIndicatorView?.isHidden = true
            activityIndicatorView?.stopAnimating()
        }
    }
    
    func loadData(){
        loadingPageDelegate?.clickLoadData()
        isLoadingData(isLoading: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
