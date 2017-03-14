//
//  RootViewController.swift
//  shortNewIOS
//
//  Created by SSd on 3/13/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import UIKit

import SwiftSpinner

class RootViewController: UIViewController {

    let service = Service()
    var version : String?
    let messageLabel = UILabel()
    let updateLabel = UILabel()
    let lightColor = UIColor.init(colorLiteralRed: 55/255, green: 123/255, blue: 143/255, alpha: 100)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = true
        updateLabel.isUserInteractionEnabled = true
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            print("Build \(build)")
        }
        view.backgroundColor = lightColor
       // messageLabel.frame = CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: CGFloat(MAXFLOAT))
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.version = version
            callData()
        }
        
        // Do any additional setup after loading the view.
    }
    func callData(){
        SwiftSpinner.show("checking version...")
        view.backgroundColor = lightColor
        service.checkVersion(params: ["platform" : 2,"version" : self.version!]){
            isSucess,checkVersionResponse in
            if isSucess {
                if(checkVersionResponse.isSupport)!{
                    self.showMainViewController()
                }else{
                    SwiftSpinner.hide()
                    self.messageLabel.text = checkVersionResponse.message_update
                    self.messageLabel.numberOfLines = 0
                    self.messageLabel.sizeToFit()
                    self.messageLabel.textColor = UIColor.white
                    self.updateLabel.text = "Update Now"
                    self.updateLabel.textAlignment = .center
                    self.updateLabel.textColor = UIColor.blue
                    let tabGet = MyTapGestureRecognizer(target: self, action: #selector(self.showAppUpdate))
                    tabGet.link = checkVersionResponse.link_update
                    self.updateLabel.addGestureRecognizer(tabGet)
                    self.addLabelViewConstraint()
                    
                }
            }else{
                self.view.backgroundColor = UIColor.black
                SwiftSpinner.sharedInstance.outerColor = UIColor.red.withAlphaComponent(0.5)
                SwiftSpinner.show("Failed to connect, Tap to retry", animated: false).addTapHandler({
                    self.callData()
                })
                
            }
        }

    }
    func addLabelViewConstraint(){
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        updateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.messageLabel)
        self.view.addSubview(updateLabel)
        let metrics = ["space" : view.frame.height/2-messageLabel.frame.height/2]
        let views = ["view" : view,"messageLabel" : messageLabel,"updateLabel" : updateLabel]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-space-[messageLabel]", options: [], metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[messageLabel]-10-|", options: [], metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[messageLabel][updateLabel]", options: [.alignAllLeading,.alignAllTrailing], metrics: metrics, views: views))
       
        
    }
    func showAppUpdate(tapRec : MyTapGestureRecognizer){
        if let link = tapRec.link, let url = URL(string: link),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    func showMainViewController() {
        SwiftSpinner.hide()
        var vcArray = self.navigationController?.viewControllers
        vcArray?.removeLast()
        vcArray?.append(MainViewController())
        self.navigationController?.setViewControllers(vcArray!, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    class MyTapGestureRecognizer: UITapGestureRecognizer {
        var link: String?
        
    }

}
