//
//  SocialResponse.swift
//  shortNewIOS
//
//  Created by SSd on 12/16/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import Foundation
struct SocialResponse {
    var title : String?
    var post_image_url : String?
    var separate_image_tag : String?
    var full_link : String?
    var fanpage_name : String?
    var social_content_type_id : Int?
    var fanpage_logo : String?
    var social_name : String?
    var social_logo : String?
    var color_tag : String?
    var video_tag : String?
    
}
extension SocialResponse {
    init?(json : [String : Any]) {
        
        // require data
        guard let title = json["title"] as? String,
            
            let separate_image_tag = json["separate_image_tag"] as? String,
            let full_link = json["full_link"] as? String,
            let fanpage_name = json["fanpage_name"] as? String,
            let social_content_type_id = json["social_content_type_id"] as? Int,
            let fanpage_logo = json["fanpage_logo"] as? String,
            let social_name = json["social_name"] as? String,
            let social_logo = json["social_logo"] as? String,
            let color_tag = json["color_tag"] as? String,
            let video_tag = json["video_tag"] as? String
        else {
            return nil
        }
        
        // option data
        if let post_image_url = json["post_image_url"] as? String{
            self.post_image_url = post_image_url
        }
        
        self.title = title
        self.separate_image_tag = separate_image_tag
        self.full_link = full_link
        self.fanpage_name = fanpage_name
        self.social_content_type_id = social_content_type_id
        self.fanpage_logo = fanpage_logo
        self.fanpage_name = fanpage_name
        self.social_name = social_name
        self.social_logo = social_logo
        self.color_tag = color_tag
        self.video_tag = video_tag
    }
}






