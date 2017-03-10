//
//  BaseCollectionViewController.swift
//  shortNewIOS
//
//  Created by SSd on 1/5/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import UIKit

protocol BaseCollectionViewControllerDelegate {
    func requiredReload()
}
class BaseCollectionViewController: UICollectionViewController {
   
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let indicatorWidth : CGFloat = 50
    let reloadWidth : CGFloat = 30
    let imageReload = UIImageView(image: UIImage(named: "reload"))
    var reloadDelegate : BaseCollectionViewControllerDelegate?
    var isLoadingData : Bool?{
        didSet{
            setState(isLoading: isLoadingData!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.clear
        indicator.frame = CGRect(x: (view.frame.width)/2 - indicatorWidth/2, y: (view.frame.height)/2 - indicatorWidth/2, width: indicatorWidth, height: indicatorWidth)
        indicator.color = UIColor.white
        imageReload.frame =  CGRect(x: (view.frame.width)/2 - reloadWidth/2, y: (view.frame.height)/2 - indicatorWidth/2, width: reloadWidth, height: reloadWidth)
        setState(isLoading: false)
    }
    
    public func setState(isLoading : Bool){
        if isLoading{
            imageReload.removeFromSuperview()
            indicator.startAnimating()
            view.insertSubview(indicator, at: 0)
            
        }else{
            indicator.removeFromSuperview()
            collectionView?.insertSubview(imageReload, at: 0)
            imageReload.isUserInteractionEnabled = true
            let tapguest = UITapGestureRecognizer(target: self, action: #selector(self.clickReload))
            imageReload.addGestureRecognizer(tapguest)
            //imageReload.target(forAction: #selector(self.clickReload), withSender: Any?.self)
        }
    }
    
    public func setReloadDelegate(delegate : BaseCollectionViewControllerDelegate){
        self.reloadDelegate = delegate
    }
    
    public func loadSucess(){
        indicator.removeFromSuperview()
        imageReload.removeFromSuperview()
    }
    
    public func clickReload(){
        if let reload = reloadDelegate {
            reload.requiredReload()
        }
    }
    func showAlert(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.message = "network error"
        
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
