//
//  SocialPresent.swift
//  shortNewIOS
//
//  Created by SSd on 4/1/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

class SocialPresent : BaseCollectionViewController {
    var loading : Bool = false
//    func loadData(page : Int, refresh : RefreshView?) {
//        loading = true
//        self.setState(isLoading: self.loading)
//        Alamofire.request("http://192.168.1.102/blog/public/api/news/getsocial/\(page)").responseJSON { response in
//            print("response page : \(page)")
//            self.loading = false
//            if response.result.isSuccess {
//                if let JSON = response.result.value {
//                    let data = JSON as? [[String: Any]]
//                    if let data1 = data{
//                        if refresh != nil {
//                            self.nextPage = 0
//                            self.layout.deleteCache()
//                            self.layout.resetMaxHeight()
//                            self.saveData = [SocialResponse]()
//                        }
//                        for item in data1 {
//                            let data = SocialResponse(json: item)
//                            if let dataUW = data {
//                                self.saveData.append(dataUW)
//                            }
//                        }
//                        self.nextPage = self.nextPage + 1
//                    }else{
//                        return
//                    }
//                }
//                if page == 0 {
//                    UIView.performWithoutAnimation {
//                        self.collectionView?.reloadData()
//                    }
//                }else{
//                    self.insertintoCollection(page)
//                }
//                self.loadSucess()
//            }else{
//                self.showAlert()
//                if self.saveData.count == 0 {
//                    self.setState(isLoading: self.loading)
//                }
//            }
//            if let refresh1 = refresh {
//                refresh1.endRefreshing()
//            }
//            self.updateLoadmoreView(showLoadmore: false)
//            
//        }
//        
//    }
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
