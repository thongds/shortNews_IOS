//
//  CustomImageAvatar.swift
//  shortNewIOS
//
//  Created by SSd on 3/10/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject,AnyObject>()
class CustomImageAvatar: UIImageView {
    
    var imageUrl : String?
    func loadImageForUrl(_ urlString : String){
        imageUrl = urlString
        let url = URL(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        if let url = url {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    if let data = data {
                        let imageToCache = UIImage(data: data)
                        
                        if let imageToCache = imageToCache{
                            self.image = imageToCache
                            imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        }else{
                            self.image = #imageLiteral(resourceName: "cloud_morning")
                            print(url)
                        }
                    }
                    
                })
            }).resume()
        }else{
            self.image = #imageLiteral(resourceName: "cloud_morning")
        }
       
    }
    
}
