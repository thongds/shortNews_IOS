//
//  NewsResponseModel.swift
//  shortNewIOS
//
//  Created by SSd on 3/3/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

class NewsResponseModel: BaseModel {

    var post_title : String?
    var post_content : String?
    var post_image : String?
    var is_video : Int?
    var created : Float?
    var video_link : String?
    var full_link : String?
    var title_color : String?
    var paper_logo : String?
    var paper_tag_color : String?
    var video_tag_image : String?

    init?(json : [String : Any]) {
        guard let postTitle = json["post_title"] as? String,
            let postContent = json["post_content"] as? String,
            let postImage = json["post_image"] as? String,
            let logoNews = json["paper_logo"] as? String,
            let titleColor = json["title_color"] as? String,
            let paperTagColor = json["paper_tag_color"] as? String,
            let isVideo = json["is_video"] as? Int,
            let videoLink = json["video_link"] as? String,
            let videoTagImage = json["video_tag_image"] as? String
            else {
                return nil
        }
        self.title_color = titleColor
        self.post_title = postTitle
        self.post_content = postContent
        self.post_image = postImage
        self.paper_logo = logoNews
        self.paper_tag_color = paperTagColor
        self.is_video = isVideo
        self.video_link = videoLink
        self.video_tag_image = videoTagImage
    }
    
    func getStruct() -> BaseModel{
        return self
    }
}
