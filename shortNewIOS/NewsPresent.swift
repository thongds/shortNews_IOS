//
//  NewsPresent.swift
//  shortNewIOS
//
//  Created by SSd on 3/3/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NewsPresent : BaseCollectionViewController{

    var refreshView : RefreshView!
    var loadMoreView : LoadMoreView?
    var saveData = [NewsResponseModel]()
    var data : NewsResponseWithSection?
    var refreshViewHeight : CGFloat = 0
    
    var oldIndex : Int = 0
    var nextPage : Int = 0
    var isLoading : Bool = false
    var layout = NewsCollectionViewLayout()
    let service = Service()
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshViewHeight = (collectionView?.frame.height)!
        refreshView = RefreshView(frame:  CGRect(x: 0, y: -refreshViewHeight, width: (collectionView?.frame.width)!, height: refreshViewHeight), scrollView: collectionView!)
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        collectionView!.insertSubview(refreshView, at: 0)
    }
    
    func progressLoadData(page : Int,refresh : RefreshView?,callback : @escaping (_ isSuccess :Bool,_ page :Int) -> Void){
        let pageParam = page;
        service.getHomeNews(page: pageParam){
            (isSuccess,data) in
            
            if(isSuccess){
                self.data = data
                if refresh != nil {
                    self.nextPage = 0
                    self.layout.deleteCache()
                    self.layout.resetMaxHeight()
                    self.saveData = [NewsResponseModel]()
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
            callback(isSuccess,pageParam)
        }
    }
}


