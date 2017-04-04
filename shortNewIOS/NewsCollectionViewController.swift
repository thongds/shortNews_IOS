//
//  NewsCollectionViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/2/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVKit
import AVFoundation
private let reuseIdentifier = "Cell_NewsCollectionViewController"
private let resueIdentifierForHeader = "newsResuseHeaderForNews"

class NewsCollectionViewController: NewsPresent{
    let loadMoreOfset = 1
     override func viewDidLoad() {
        super.viewDidLoad()
        // set event callback
        setReloadDelegate(delegate: self)
        refreshView.delegate = self
        //load data at first time
        self.loadAndUpdateDataView(page: nextPage, refresh: nil)
        layout = collectionViewLayout as! NewsCollectionViewLayout
        layout.space = 10
        layout.delegate = self
       
        collectionView?.showsVerticalScrollIndicator = true
        collectionView?.isPagingEnabled = false
        self.collectionView!.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: resueIdentifierForHeader)
        layout.headerReferenceSize = CGSize(width: 100, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: resueIdentifierForHeader, for: indexPath) as! HeaderView
        if(nextPage == 1){
            sectionHeaderView.message = self.data?.message
        }
        return sectionHeaderView
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return saveData.count
    }
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
   }
    
     
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
       // Configure the cell
        cell.contentView.backgroundColor = UIColor.white
        cell.setNewsDelegate(delegate: self)
        if saveData.count > 0 {
            cell.newsResponse = saveData[indexPath.item]
            oldIndex = saveData.count
            if indexPath.item >= saveData.count - loadMoreOfset && !isLoading && !refreshView.isRefreshing {
                    updateLoadmoreView(showLoadmore: true)
                 //   loadData(nextPage, refresh: nil)
                self.loadAndUpdateDataView(page: nextPage, refresh: nil)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let response = saveData[indexPath.item]
        if response.is_video == 1 {
            let ulrPlay = URL(string: response.video_link!)
            let player = AVPlayer(url: ulrPlay!)
            let playController = PlayVideoViewController()
            playController.player = player
            playController.player?.play()
            
            self.present(playController, animated: true, completion: nil)
        }
    }
    
    func updateLoadmoreView(showLoadmore : Bool){
            UIView.performWithoutAnimation {
                let loadMoreHeight : CGFloat = 40
                if showLoadmore {
                    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
                    indicator.color = UIColor.white
                    loadMoreView = LoadMoreView(frame:  CGRect(x: 0, y:  (collectionView?.contentSize.height)!, width: (collectionView?.frame.width)! , height: loadMoreHeight), scrollView: collectionView!)
                    loadMoreView?.translatesAutoresizingMaskIntoConstraints = false
                    let indicatorWidth : CGFloat = 30
                    indicator.frame = CGRect(x: (loadMoreView?.frame.width)!/2-indicatorWidth/2, y: (loadMoreView?.frame.height)!/2 - indicatorWidth/2, width: indicatorWidth, height: indicatorWidth)
                    loadMoreView?.addSubview(indicator)
                    loadMoreView?.backgroundColor = UIColor.clear
                    collectionView?.contentInset.bottom += loadMoreHeight
                    collectionView?.insertSubview(loadMoreView!, at: 0)
    
                    indicator.startAnimating()
                }else{
                    if let LoadMoreView = loadMoreView {
                        LoadMoreView.removeFromSuperview()
                        self.loadMoreView = nil
                        collectionView?.contentInset.bottom -= loadMoreHeight
                    }
                }
    
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
            }
        }
    
      func loadAndUpdateDataView(page : Int,refresh : RefreshView?){
        self.progressLoadData(page: page, refresh: refresh){
            (isSuccess,page) in
            if(isSuccess){
                if page == 0 {
                    UIView.performWithoutAnimation {
                        self.collectionView?.reloadData()
                    }
                    
                }else{
                    self.insertIntoCollection(page)
                }
            }else{
                self.showAlert()
                if self.saveData.count == 0 {
                    self.setState(isLoading: self.isLoading)
                }
            }
            self.updateLoadmoreView(showLoadmore: false)
            
        }
        
      }
    
}

extension NewsCollectionViewController :  NewsLayoutDelegate {
    func collectionView(_ collectionView : UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat{
        if saveData.count > 0 {
            if let ads = saveData[indexPath.item].is_ads,ads{
                return 300
            }else{
                let text = saveData[indexPath.item].post_content
                let contentText = UILabel()
                var isHaveVideTag : Bool = false
                
                if let isVideo = saveData[indexPath.item].is_video{
                    isHaveVideTag = isVideo==1 ? true : false
                }
                //title
                let titleText = UILabel()
                titleText.frame = CGRect(x: 0, y: 0, width: UtilHelper.generateTitleTextMaxWidthForNewsPage(isHaveTagVideo: isHaveVideTag), height: CGFloat(MAXFLOAT))
                titleText.text = saveData[indexPath.item].post_title
                titleText.numberOfLines = 0
                titleText.sizeToFit()
                
                //content
                contentText.frame = CGRect(x: 0, y: 0, width: UtilHelper.generateContentTextMaxWidthForNewsPage(), height: CGFloat(MAXFLOAT))
                contentText.text = text
                contentText.numberOfLines = 0
                contentText.sizeToFit()
                
                let leftCellContentHeight = Contraint.normalSpace.rawValue + Contraint.logoHeight.rawValue + Contraint.normalSpace.rawValue + Contraint.contentImageHeight.rawValue
                let rightCellContentHeight = titleText.frame.height + Contraint.normalSpace.rawValue + contentText.frame.height + Contraint.normalSpace.rawValue
                print("heightMax 1 \(max(leftCellContentHeight + Contraint.normalSpace.rawValue, rightCellContentHeight + Contraint.normalSpace.rawValue))")
                return max(leftCellContentHeight + Contraint.normalSpace.rawValue, rightCellContentHeight + Contraint.normalSpace.rawValue)
            }
            
        }
        return 300
    }

}
extension NewsCollectionViewController : RefreshDelegate {
    
    func refreshViewDidRefresh(refreshView : RefreshView){
        self.loadAndUpdateDataView(page: 0, refresh: refreshView)
    }
}
extension NewsCollectionViewController : BaseCollectionViewControllerDelegate {
    func requiredReload() {
        self.loadAndUpdateDataView(page: 0, refresh: nil)
    }
}






















