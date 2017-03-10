//
//  SocialCollectionViewDetailCollectionViewController.swift
//  shortNewIOS
//
//  Created by SSd on 12/16/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit
import Alamofire
private let reuseIdentifier = "Cell_SocialCollectionViewDetailCollectionViewController"

class SocialCollectionViewDetailCollectionViewController: UICollectionViewController {

    var saveData = [SocialResponse]()
    var layout = SocialDetailCollectionViewLayout()
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
        loadData()
        layout = collectionViewLayout as! SocialDetailCollectionViewLayout
        layout.space = 0
      
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        // collectionView?.backgroundColor = UIColor.init(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 200/255)
        collectionView?.backgroundColor = UIColor.gray
        collectionView?.contentInset.right = 20
        collectionView?.contentSize = CGSize(width:  CellContraint.cellWidth.rawValue * 3, height: (collectionView?.frame.size.height)!)
    
        collectionView?.frame.size.width =  CellContraint.cellWidth.rawValue + 40
        collectionView?.clipsToBounds = false
        collectionView?.allowsMultipleSelection = true
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.alpha = 1.0
//        blurEffectView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        //self.view = blurEffectView
//        collectionView?.backgroundView = blurEffectView
        // Register cell classes
        self.collectionView!.register(SocialCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        print("call loadData")
        Alamofire.request("http://localhost/blog/public/api/news/getsocial/0").responseJSON { response in
            if response.result.isSuccess {
                if let JSON = response.result.value {
                    let data = JSON as? [[String: Any]]
                    if let data1 = data{
                        for item in data1 {
                            let data = SocialResponse(json: item)
                            if let dataUW = data {
                                self.saveData.append(dataUW)
                            }
                        }
                    }else{
                        return
                    }
                }
                self.collectionView?.reloadData()
                
            }else {
                print(response.result.error)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //print("call cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SocialCollectionViewCell
        cell.contentView.backgroundColor = UIColor.white
        if saveData.count > 0 {
            cell.socialResponse = saveData[indexPath.item]
            cell.layer.cornerRadius = 9
            cell.layer.masksToBounds = true
        }
        
        return cell
    }
    
    func pagedScrollOffsetForProposedOffset(_ offset: CGPoint) -> CGPoint {
        let pageWidth = 10 + CellContraint.cellWidth.rawValue
        let pageDistance = CGFloat(fmod(offset.x, pageWidth))
        
        var newOffset = offset
        
        if (pageDistance < pageWidth / 2) {
            newOffset.x -= pageDistance
        } else {
            newOffset.x += pageWidth - pageDistance
        }
        
        return newOffset
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = pagedScrollOffsetForProposedOffset(targetContentOffset.pointee)
    }
    
    
}
extension SocialCollectionViewDetailCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 400, height: collectionView.frame.height*2/3)
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("visible cell \(collectionView?.visibleCells.count)")
    }
}
extension SocialCollectionViewDetailCollectionViewController :  NewsLayoutDelegate {
    
    func collectionView(_ collectionView : UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat{
        return 300
    }
}
