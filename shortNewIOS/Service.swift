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
    
    
    func checkVersion(params: [String : Any], callback : @escaping(Bool,CheckVersionResponse) -> Void){
        let url = "http://tinexpress.vn/api/home/check-version"
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON{
            response in
            if  response.result.isSuccess{
                if let JSON = response.result.value{
                    let data = JSON as? [String : Any]
                    if let data = data,let checkResponse = CheckVersionResponse(json: data) {
                        callback(true, checkResponse)
                    }else{
                        callback(false, CheckVersionResponse())
                    }
                }
            }else{
                callback(false,CheckVersionResponse())
            }
        }
    }
    
    func getHomeNews(page : Int,callback : @escaping (Bool,NewsResponseWithSection)->Void){
        let url = "http://tinexpress.vn/api/news/getnews?page=\(page)"
        Alamofire.request(url).responseJSON { response in
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
                }
            }else{
                callback(false,NewsResponseWithSection())
            }
            
        }

    }
    
    func getHomeSocial(page : Int,callback : @escaping (Bool,SocialResponseWithSection) -> Void){
        let url = "http://tinexpress.vn/api/news/get-social?page=\(page)"
        Alamofire.request(url).responseJSON{ response in
            if response.result.isSuccess{
                if let JSON = response.result.value{
                    let data = JSON as? [String : Any]
                    if let data = data,let dataResponse = SocialResponseWithSection(json: data){
                        callback(true,dataResponse)
                    }else{
                        callback(false,SocialResponseWithSection())
                    }
                }
            }else{
                callback(false,SocialResponseWithSection())
            }
        }
    }
    
}

















