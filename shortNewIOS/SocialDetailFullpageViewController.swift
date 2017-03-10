//
//  SocialDetailFullpageViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/30/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit
import AVFoundation

class SocialDetailFullpageViewController: UIViewController {
    
    var imageLink : [String]?{
        didSet{
            
        }
    }
    let scrollView = UIScrollView()
    let fanpageLogo : CustomImage = {
        let imageView = CustomImage()
        imageView.image = UIImage(named: "taylor_swift_bad_blood")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let boundingRect = CGRect(x: 0, y: 0, width: view.frame.width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: (fanpageLogo.image?.size)!, insideRect: boundingRect)
        
        // Do any additional setup after loading the view.
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
