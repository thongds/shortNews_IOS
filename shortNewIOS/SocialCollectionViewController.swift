//
//  SocialCollectionViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/2/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell_SocialCollectionViewController"
private let resueIdentifierForHeader = "newsResuseHeaderForSocial"

class SocialCollectionViewController: SocialPresent, NewsLayoutDelegate  {
    var refreshView : RefreshView!
    var refreshViewHeight : CGFloat = 0
    var loadMoreView : LoadMoreView?
    var oldIndex : Int = 0
    var colors: [UIColor] {
        get {
            var colors = [UIColor]()
            let palette = [UIColor.red, UIColor.green, UIColor.blue, UIColor.orange, UIColor.purple, UIColor.yellow]
            var paletteIndex = 0
            for _ in 0..<10 {
                colors.append(palette[paletteIndex])
                paletteIndex = paletteIndex == (palette.count - 1) ? 0 : paletteIndex + 1
            }
            return colors
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setReloadDelegate(delegate: self)
        //loadData(page: nextPage,refresh : nil)
        self.loadAndUpdateDataView(page: nextPage, refresh: nil)
        layout = collectionViewLayout as! NewsCollectionViewLayout
        layout.space = 10
        layout.delegate = self
        // refresh config
        refreshViewHeight = (collectionView?.frame.height)!
        refreshView = RefreshView(frame:  CGRect(x: 0, y: -refreshViewHeight, width: (collectionView?.frame.width)!, height: refreshViewHeight), scrollView: collectionView!)
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        collectionView!.insertSubview(refreshView, at: 0)
        refreshView.delegate = self
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.isPagingEnabled = false
        //collectionView?.backgroundColor = UIColor.init(colorLiteralRed: 55/255, green: 123/255, blue: 143/255, alpha: 100)
        // Register cell classes
        self.collectionView!.register(SocialCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //register header
        self.collectionView!.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: resueIdentifierForHeader)
        layout.headerReferenceSize = CGSize(width: 100, height: 100)
        
        // Do any additional setup after loading the view.
    }
      
    func insertIntoCollection(_ page : Int){
        self.layout.deleteCache()
        print("saveData count \(self.saveData.count)")
        var indexPathCollect = [IndexPath]()
        for i in self.oldIndex..<self.saveData.count{
            let indexPath = IndexPath(item: i, section: 0)
            indexPathCollect.append(indexPath)
        }
        UIView.performWithoutAnimation {
            self.collectionView?.insertItems(at: indexPathCollect)
        }


   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let endPoint = scrollView.frame.height + scrollView.contentOffset.y
//        if endPoint >= scrollView.contentSize.height && !loading && !refreshView.isRefreshing && !isNoDataToLoad{
//            updateLoadmoreView(showLoadmore: true)
//            loadData(page: nextPage, refresh: nil)
//        }
        refreshView.scrollViewDidScroll(scrollView)
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height && !isLoading {
            updateLoadmoreView(showLoadmore: true)
            //loadData(page: nextPage, refresh: nil)
            self.loadAndUpdateDataView(page: nextPage, refresh: nil)
        }
        
        
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: resueIdentifierForHeader, for: indexPath) as! HeaderView
        if(nextPage == 1){
            sectionHeaderView.message = self.data?.message
        }
        return sectionHeaderView
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transitionDelegate = TransitionDelegate()
        if saveData.count > 0 {
            if let isVideo = saveData[indexPath.item].social_content_type_id {
                if isVideo == ContentTypeEnum.YOUTUBE.rawValue{
                    let vc = YTPlayViewViewController()
                    vc.transitioningDelegate = transitionDelegate
                    vc.modalPresentationStyle = .custom
                    vc.loadYtId(id: getYTId(data: saveData[indexPath.item]))
                    self.present(vc, animated: true, completion: nil)
                }else{
                    let vc = SocialDetailSingleViewController()
                    let socialResponse = saveData[indexPath.item]
                    if let contentImageUrl = socialResponse.post_image_url{
                        if let sperateTag = socialResponse.separate_image_tag{
                            let linkImage = contentImageUrl.components(separatedBy: sperateTag )
                            if linkImage.count > 0 {
                               vc.imageLinks = linkImage
                               vc.transitioningDelegate = transitionDelegate
                               vc.modalPresentationStyle = .custom
                               self.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
            }
        }
    }
    func updateLoadmoreView(showLoadmore : Bool){
        UIView.performWithoutAnimation {
            let loadMoreHeight : CGFloat = 40
            if showLoadmore {
                let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
                indicator.color = UIColor.white
//                loadMoreView = LoadMoreView(frame:  CGRect(x: 0, y:  (collectionView?.contentSize.height)!, width: (collectionView?.frame.width)! , height: loadMoreHeight), scrollView: collectionView!)
                
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
                        self.collectionView?.contentInset.bottom -= loadMoreHeight
                }
            }
       }
    }
    
    func loadAndUpdateDataView(page : Int,refresh : RefreshView?){
        self.loadDataProcess(page: page, refresh: refresh){
            (isSuccess,page) in
            self.isLoading = false
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
            if refresh != nil{
                refresh?.endRefreshing()
            }
            self.updateLoadmoreView(showLoadmore: false)
            self.setState(isLoading: self.isLoading)    
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return saveData.count
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell \(indexPath.item)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SocialCollectionViewCell
        cell.contentView.backgroundColor = UIColor.white
        if saveData.count > 0 {
            cell.socialResponse = saveData[indexPath.item]
            oldIndex = saveData.count
            
            cell.layer.cornerRadius = 9
            cell.layer.masksToBounds = true
            let cellWidth = collectionView.frame.width-(UtilHelper.getMarginCell()*2)
            let leftWidth = cellWidth - (Contraint.logoWidth.rawValue + 3*Contraint.normalSpace.rawValue)
            cell.fanPageName.numberOfLines = 0
            cell.fanPageName.preferredMaxLayoutWidth = Contraint.logoWidth.rawValue
            cell.titleText.numberOfLines = 0
            cell.titleText.preferredMaxLayoutWidth = leftWidth
//            if indexPath.item >= saveData.count - 1 && !isLoading && !refreshView.isRefreshing  {
//                print(saveData.count)
//                print(indexPath.item)
//                updateLoadmoreView(showLoadmore: true)
//                //loadData(page: nextPage, refresh: nil)
//                self.loadAndUpdateDataView(page: nextPage, refresh: nil)
//            }
        }
        return cell
    }
    
   
    func collectionView(_ collectionView : UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat{
        
        let fanPageName = UILabel()
        let titleLabel = UILabel()
        let cellWidth = collectionView.frame.width-(UtilHelper.getMarginCell()*2)
        let leftWidth = cellWidth - (Contraint.logoWidth.rawValue + 3*Contraint.normalSpace.rawValue)
      
        var leftHeight : CGFloat = 0
        var rightHeight : CGFloat = 0
        var fanpageNameHeight : CGFloat = 0
        var titleTextHeight : CGFloat = 0
        var contentHeight : CGFloat = 0
        if saveData.count > 0 {
            let response = saveData[indexPath.item]
            if let fanPageNameText = response.fanpage_name  {
                fanPageName.frame = CGRect(x: 0, y: 0, width: Contraint.logoWidth.rawValue , height: CGFloat(MAXFLOAT))
                fanPageName.text = fanPageNameText
                fanPageName.numberOfLines = 0
                fanPageName.sizeToFit()
                fanpageNameHeight = fanPageName.frame.height
                
            }
            if let titleText = response.title {
                titleLabel.text = titleText
                titleLabel.numberOfLines = 0
                titleLabel.frame = CGRect(x: 0, y: 0, width: leftWidth, height: CGFloat(MAXFLOAT))
                titleLabel.sizeToFit()
                titleTextHeight = titleLabel.frame.height
            }
            leftHeight = Contraint.normalSpace.rawValue + Contraint.logoHeight.rawValue + Contraint.logoWidth.rawValue + Contraint.normalSpace.rawValue + fanpageNameHeight + Contraint.normalSpace.rawValue
            
            if saveData[indexPath.item].post_image_url != nil{
                contentHeight =  Contraint.contentImageHeight.rawValue
            }else{
               contentHeight -= Contraint.normalSpace.rawValue
            }
            rightHeight = titleTextHeight + Contraint.normalSpace.rawValue + contentHeight + Contraint.normalSpace.rawValue
            return max(leftHeight,rightHeight)
        }
        
        return 300
       
    }
}
extension SocialCollectionViewController : RefreshDelegate {
    
    func refreshViewDidRefresh(refreshView : RefreshView){
        //loadData(page: 0, refresh: refreshView)
        self.loadAndUpdateDataView(page: 0, refresh: refreshView)
    }
}
extension SocialCollectionViewController : BaseCollectionViewControllerDelegate {
    func requiredReload() {
        //loadData(page: 0, refresh: nil)
        self.loadAndUpdateDataView(page: 0, refresh: nil)
    }
}




