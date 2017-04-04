//
//  SocialPresent.swift
//  shortNewIOS
//
//  Created by SSd on 4/1/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

class SocialPresent : BaseCollectionViewController {
    var isLoading : Bool = false
    var data : SocialResponseWithSection?
    var saveData = [SocialResponse]()
    var layout = NewsCollectionViewLayout()
    var nextPage : Int = 0
    let service = Service()
    
    func loadDataProcess(page : Int,refresh : RefreshView?,callback : @escaping(Bool, Int)->Void){
    
        service.getHomeSocial(page: page) { (isSuccess, data) in
            
            if(isSuccess){
                self.data = data
                if refresh != nil {
                    self.nextPage = 0
                    self.layout.deleteCache()
                    self.layout.resetMaxHeight()
                    self.saveData = [SocialResponse]()
                }
                let newData = (self.data?.dataResponse)!
                if(self.saveData.count == 0){
                    self.saveData = newData
                }else{
                    for key in 0..<newData.count{
                        self.saveData.append(newData[key])
                    }
                }
                
            }
            self.nextPage = self.nextPage + 1
            self.loadSucess()
            callback(isSuccess,page)
            
        }
        
    }
    
    func getYTId(data : SocialResponse) -> String{
        if let contentImageUrl = data.post_image_url{
            if let sperateTag = data.separate_image_tag{
                let linkImage = contentImageUrl.components(separatedBy: sperateTag )
                if linkImage.count > 0 {
                    if let social_content_type_id = data.social_content_type_id {
                        //let linkImageIndex = social_content_type_id == 1 ? linkImage[0] : linkImage[1]
                        if social_content_type_id == 0 {
                            return linkImage[0]
                        }
                    }
                }
            }
            
        }
        return ""
    }

}
