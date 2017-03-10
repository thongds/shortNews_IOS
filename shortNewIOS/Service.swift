//
//  Service.swift
//  shortNewIOS
//
//  Created by SSd on 3/3/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation
import Alamofire
class Service {
    
    func getHomeNews(page : Int,callback : @escaping (Bool,NewsResponseWithSection)->Void){
        let url = "http://192.168.1.102/ShortNews_Server/public/api/news/getnews?page=\(page)"
        Alamofire.request(url).responseJSON { response in
            //self.isLoading = false
            var dataResponse  :  NewsResponseWithSection? = nil
            if response.result.isSuccess {
                if let JSON = response.result.value {
                    let data = JSON as? [String: Any]
                    dataResponse = NewsResponseWithSection(json: data!)
                    if let dataResponse = dataResponse{
                        callback(true, dataResponse)
                    }else{
                        callback(false, NewsResponseWithSection())
                    }
                    
//                    let data = JSON as? [[String: Any]]
//                    
//                    if let data1 = data{
//                        for item in data1 {
//                            let data = NewsResponseModel(json: item)
//                            if let dataUW = data {
//                                dataResponse.append(dataUW)
//                            }
//                        }
//                        callback(true,dataResponse)
//                    }else{
//                        callback(false,dataResponse)
//                    }
                }
            }else{
                callback(false,NewsResponseWithSection())
            }
            
        }

    }
    
}
