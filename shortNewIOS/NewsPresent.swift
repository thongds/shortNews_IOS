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

class NewsPresent : UICollectionViewController{

    var refreshView : RefreshView!
    let loadingHeight : CGFloat = 50
    var loadingView : LoadingPage?
    var isLoading : Bool = false
    var saveData = [NewsResponseModel]()
    var data : NewsResponseWithSection?
    var refreshViewHeight : CGFloat = 0
    
    var oldIndex : Int = 0
    var nextPage : Int = 0
    var layout = NewsCollectionViewLayout()
    let service = Service()
    
    var loadMoreViewControl : LoadMoreView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.clear
        loadMoreViewControl = LoadMoreView(scrollView: collectionView!)
    
        refreshViewHeight = (collectionView?.frame.height)!
        refreshView = RefreshView(frame:  CGRect(x: 0, y: -refreshViewHeight, width: (collectionView?.frame.width)!, height: refreshViewHeight), scrollView: collectionView!)
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        loadingView = LoadingPage(frame: CGRect(x: (view.frame.width - loadingHeight)/2, y: (view.frame.height - loadingHeight)/2, width: loadingHeight, height: loadingHeight))
        view.addSubview(loadingView!)
        loadingView?.loadingPageDelegate = self
        collectionView!.insertSubview(refreshView, at: 0)
    }
    
    func progressLoadData(page : Int,refresh : RefreshView?,callback : @escaping (_ isSuccess :Bool,_ page :Int) -> Void){
        isLoading = true
        //self.setState(isLoading: self.isLoading)
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
            //self.loadSucess()
            callback(isSuccess,pageParam)
        }
    }
    
    
    func insertIntoCollection(_ page : Int){
        layout.deleteCache()
        var indexPathCollect = [IndexPath]()
        for i in oldIndex..<saveData.count{
            let indexPath = IndexPath(item: i, section: 0)
            indexPathCollect.append(indexPath)
            
        }
        UIView.performWithoutAnimation {
            self.collectionView?.insertItems(at: indexPathCollect)
            //                DispatchQueue.main.async(execute: {
            //
            //                })
        }
        
    }
    
    func loadAndUpdateDataView(page : Int,refresh : RefreshView?){
        self.progressLoadData(page: page, refresh: refresh){
            (isSuccess,page) in
            self.isLoading = false
            if(isSuccess){
                self.loadingView?.isHidden = true
                if page == 0 {
                    UIView.performWithoutAnimation {
                        self.collectionView?.reloadData()
                    }
                    
                }else{
                    self.insertIntoCollection(page)
                    self.loadMoreViewControl?.updateLoadmoreView(showLoadmore: false)
                }
            }else{
                self.showAlert()
                if self.saveData.count == 0 {
                    self.loadingView?.isLoadingData(isLoading: false)
                }
            }
            
            if refresh != nil{
                refresh?.endRefreshing()
            }
            //self.setState(isLoading: self.isLoading)
            //self.updateLoadmoreView(showLoadmore: false)
        }
        
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height && !isLoading{
            isLoading = true
            if let loadmoreView = self.loadMoreViewControl {
                loadmoreView.updateLoadmoreView(showLoadmore: true)
                self.loadAndUpdateDataView(page: nextPage, refresh: nil)
            }
        }
    }
    func showAlert(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.message = "network error"
        
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
extension NewsPresent : ClickNewsCellEvent{
    func clickTitle(id : Int){
        let value = String(id)
        GoogleAnalyticHelpper.sendAction(withCategory: .newsEvents, action: .click, label: value)
    }
    
    func clickVideo(id : Int){
    }
    
    func clickAds(adsCode : String){
    }
}
extension NewsPresent : LoadDataDelegate{
    func clickLoadData(){
        self.loadAndUpdateDataView(page: 0, refresh: nil)
    }
}

