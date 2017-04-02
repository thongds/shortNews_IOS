//
//  SocialResponseWithSection.swift
//  shortNewIOS
//
//  Created by SSd on 4/2/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

class SocialResponseWithSection{
    var message : MessageHeader?
    private var rawData : [[String: Any]]?
    var dataResponse  = [SocialResponse]()
    init?(json : [String : Any]) {
        guard let messageJson = json["message"] as? [String : Any],
            let rawData = json["data"] as? [[String : Any]]
            else{
                return nil
        }
        self.message = MessageHeader(json: messageJson)
        self.rawData = rawData
        for item in self.rawData! {
            let data = SocialResponse(json: item)
            if let dataUW = data {
                dataResponse.append(dataUW)
            }
        }
    }
}
