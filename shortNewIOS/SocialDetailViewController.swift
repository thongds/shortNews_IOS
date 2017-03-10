//
//  SocialDetailViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/18/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class SocialDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground()
        addView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewBackground(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 1.0
        blurEffectView.frame = view.frame
        view = blurEffectView
    }
    
    func addView(){
        let socialDetailCV = SocialCollectionViewDetailCollectionViewController(collectionViewLayout: SocialDetailCollectionViewLayout())
        socialDetailCV.view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        socialDetailCV.view.frame = CGRect(x: 40, y: 60, width:view.frame.width, height: 600)
        view.addSubview(socialDetailCV.view)
        addChildViewController(socialDetailCV)
        didMove(toParentViewController: self)
        
//        let views = ["view":view, "detailCV": socialDetailCV.view]
//        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[detailCV(==view)]|", options: [], metrics: nil, views: views))
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[detailCV(==view)]|", options: [], metrics: nil, views: views))
        
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
