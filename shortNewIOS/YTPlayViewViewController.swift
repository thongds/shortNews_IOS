//
//  YTPlayViewViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/24/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YTPlayViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground()
        
    }
    
    func loadYtId(id : String){
        let yt = YTPlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2))
        view.addSubview(yt)
        yt.load(withVideoId: id)
    
    }
    
    func viewBackground(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 1.0
        blurEffectView.frame = view.frame
        view = blurEffectView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.closeView))
        view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func closeView(){
        self.dismiss(animated: true, completion: nil)
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
