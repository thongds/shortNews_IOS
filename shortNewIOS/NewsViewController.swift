//
//  NewsViewController.swift
//  shortNewIOS
//
//  Created by SSd on 3/9/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    let viewHeader = UIView()
    let newCollectionView = NewsCollectionViewController(collectionViewLayout: NewsCollectionViewLayout())
    let cloudImage = UIImageView(image: #imageLiteral(resourceName: "cloud_ningt_sm"))
    let todayLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewConstraint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addViewConstraint(){
        viewHeader.translatesAutoresizingMaskIntoConstraints = false
        newCollectionView.view.translatesAutoresizingMaskIntoConstraints = false
        viewHeader.backgroundColor = UIColor.clear
        addCollectionViewController(collectionView: newCollectionView)
        view.addSubview(viewHeader)
        let views = ["view": view,"viewHeader" : viewHeader,"newCollectionView" : newCollectionView.view,"cloudImage" : cloudImage,
                     "todayLabel": todayLabel]
        let metrics = ["viewHeaderHeigh" : 40,"space" : 10]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[viewHeader(==viewHeaderHeigh)]", options: [], metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[viewHeader(==view)]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[viewHeader][newCollectionView]|", options: [.alignAllTrailing,.alignAllLeading], metrics: nil, views: views))
        
        // config header constraint
        cloudImage.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        viewHeader.addSubview(cloudImage)
        viewHeader.addSubview(todayLabel)
        todayLabel.text = "Tin Chính Sáng Nay 3/7/2017"
        todayLabel.textColor = UIColor.white
        todayLabel.textAlignment = .center
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[cloudImage]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[cloudImage(60)]-space-[todayLabel]", options: [.alignAllTop,.alignAllBottom], metrics: metrics, views: views))
        
    }

    fileprivate func addCollectionViewController( collectionView: UICollectionViewController) {
        collectionView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView.view)
        addChildViewController(collectionView)
        collectionView.didMove(toParentViewController: self)
        
    }

}
