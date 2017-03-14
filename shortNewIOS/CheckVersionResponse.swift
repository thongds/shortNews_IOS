//
//  CheckVersionResponse.swift
//  shortNewIOS
//
//  Created by SSd on 3/13/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

struct CheckVersionResponse {
    var isSupport : Bool?
    var link_update : String?
    var message_update : String?
    
    init?(json : [String : Any]){
        guard let isSupport = json["is_support"] as? Bool
            else {
                return nil
         }
        if let link_update = json["link_update"] as? String{
            self.link_update = link_update
        }
        if let message_update = json["message_update"] as? String{
            self.message_update = message_update
        }
        self.isSupport = isSupport
    }
    init(){
    }
}
