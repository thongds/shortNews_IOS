//
//  MainViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/2/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit


class MainViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    let leftBar = UILabel()
    let rightBar = UILabel()
    let lightColor = UIColor.init(colorLiteralRed: 55/255, green: 123/255, blue: 143/255, alpha: 100)
    let darkColor = UIColor.init(colorLiteralRed: 21/255, green: 40/255, blue: 45/255, alpha: 100)
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = "Natural Topic"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = UIColor.red
         //custome header view
        
        leftBar.translatesAutoresizingMaskIntoConstraints = false
        leftBar.backgroundColor = lightColor
        leftBar.textAlignment = .center
        leftBar.text = "Tin Tức"
        leftBar.textColor = UIColor.white
        
        rightBar.translatesAutoresizingMaskIntoConstraints = false
        rightBar.backgroundColor = darkColor
        rightBar.textAlignment = .center
        rightBar.text = "Mạng Xã Hội"
        rightBar.textColor = UIColor.white
        
        headerView.addSubview(leftBar)
        headerView.addSubview(rightBar)
        
        let headerBarViews = ["headerView": headerView,"leftBar" : leftBar,"rightBar" : rightBar]
        let metrict = ["leftBarWidth" : view.frame.width/2]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[leftBar]|", options: [], metrics: nil, views: headerBarViews))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftBar(==leftBarWidth)][rightBar]|", options: [.alignAllTop,.alignAllBottom], metrics: metrict, views: headerBarViews))
       
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = (navigationController?.navigationBar.frame.height)! + statusBarHeight - CGFloat(5)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.init(colorLiteralRed: 55/255, green: 123/255, blue: 143/255, alpha: 100)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)
        view.addSubview(headerView)
        view.backgroundColor = UIColor.white
        let views = ["view" : view,"scrollView" : scrollView,"headerView": headerView]
        let metric = ["navigationBarHeight":navigationBarHeight,"statusBarHeight": statusBarHeight]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerView(==navigationBarHeight)]", options: [], metrics: metric, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerView]|", options: [], metrics: metric, views: views))
       
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[headerView][scrollView]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views))
        let newCollectionView = NewsCollectionViewController(collectionViewLayout: NewsCollectionViewLayout())
        //let newCollectionView = NewsViewController()
        addCollectionViewController(collectionView: newCollectionView)
        let socialCollectionView = SocialCollectionViewController(collectionViewLayout: NewsCollectionViewLayout())
        addCollectionViewController(collectionView: socialCollectionView)
        let scrollViews = ["scrollView" : scrollView,"newCollectionView" : newCollectionView.view,"socialCollectionView":socialCollectionView.view]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[newCollectionView(==scrollView)]|", options: [], metrics: nil, views: scrollViews))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[newCollectionView(==scrollView)][socialCollectionView(==scrollView)]|", options: [.alignAllTop,.alignAllBottom], metrics: nil, views: scrollViews))
       
        //click event
        
        rightBar.isUserInteractionEnabled = true
        let tapGesture = MyTapGestureRecognizer(target: self, action: #selector(MainViewController.tapGest) )
        tapGesture.isLeft = false
        rightBar.addGestureRecognizer(tapGesture)
        //rightBar.target(forAction: #selector(self.tapGest), withSender: Any?.self)
            //left
        leftBar.isUserInteractionEnabled = true
        let tapGestureLeft = MyTapGestureRecognizer(target: self, action: #selector(MainViewController.tapGest) )
        tapGestureLeft.isLeft = true
        leftBar.addGestureRecognizer(tapGestureLeft)
        //leftBar.target(forAction: #selector(self.tapGest), withSender: Any?.self)
    }
 
    func tapGest(gestureRecognizer: MyTapGestureRecognizer)  {
        print(gestureRecognizer.isLeft)
        if(gestureRecognizer.isLeft){
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            GoogleAnalyticHelpper.sendAction(withCategory: .global, action: .clickNews, label: " ")
        }else{
            scrollView.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: false)
            GoogleAnalyticHelpper.sendAction(withCategory: .global, action: .clickSocial, label:" ")
        }
        changeTabColor()

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating \(scrollView.contentOffset.x)")
        changeTabColor()
    }
    func changeTabColor(){
        if scrollView.contentOffset.x >= scrollView.frame.width {
            rightBar.backgroundColor = lightColor
            leftBar.backgroundColor = darkColor
            
        }else{
            leftBar.backgroundColor = lightColor
            rightBar.backgroundColor = darkColor
        }
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    fileprivate func addCollectionViewController( collectionView: UIViewController) {
        collectionView.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(collectionView.view)
        addChildViewController(collectionView)
        collectionView.didMove(toParentViewController: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        GoogleAnalyticHelpper.sendScreen(screenName :.home)
    }

}
class MyTapGestureRecognizer: UITapGestureRecognizer {
    var isLeft: Bool = true
}
