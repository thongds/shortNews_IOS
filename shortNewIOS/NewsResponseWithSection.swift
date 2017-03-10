//
//  NewsResponseWithSection.swift
//  shortNewIOS
//
//  Created by SSd on 3/7/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

class NewsResponseWithSection {

    var message : MessageHeader?
    private var rawData : [[String: Any]]?
    var dataResponse  = [NewsResponseModel]()
    init?(json : [String : Any]) {
        guard let messageJson = json["message"] as? [String : Any],
        let rawData = json["data"] as? [[String : Any]]
        else{
                return nil
        }
        self.message = MessageHeader(json: messageJson)
        self.rawData = rawData
        for item in self.rawData! {
            let data = NewsResponseModel(json: item)
            if let dataUW = data {
                     dataResponse.append(dataUW)
                 }
             }
    }
    init() {
        
    }
}
struct MessageHeader {
    var welcomeMessage : String?
    var eventMessage : String?
    var avatar : String?
    init() {
        
    }
}
extension MessageHeader{
    
    init?(json : [String : Any]){
        guard let welcomeMessage = json["welcome_message"] as? String,
            let avatar = json["avatar"] as? String
        else{
                return nil
        }
        if let eventMessage  = json["event_message"] as? String {
            self.eventMessage = eventMessage
        }
        self.avatar = avatar
        self.welcomeMessage = welcomeMessage
        
    }
}
