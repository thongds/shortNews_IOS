//
//  PlayVideoViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/22/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class PlayVideoViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    
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
