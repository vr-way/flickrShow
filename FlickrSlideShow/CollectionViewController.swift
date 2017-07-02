//
//  CollectionViewController.swift
//  FlickrSlideShow
//
//  Created by vrway on 01/07/2017.
//  Copyright © 2017 vrway. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    fileprivate let borderWidth: CGFloat = 3.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 3
    
    var arrayOfImage = [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]

    override func viewDidLoad() {
        super.viewDidLoad()

      
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        
        
  
    }

//    func getFlickrPhotos()
//    {
//        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
//        let url :String = "https://api.flickr.com/services/rest/"
//        let parameters :Dictionary = [
//            "method"         : "flickr.interestingness.getList",
//            "api_key"        : "86997f23273f5a518b027e2c8c019b0f",
//            "per_page"       : "99",
//            "format"         : "json",
//            "nojsoncallback" : "1",
//            "extras"         : "url_q,url_z",
//            ]
//        let requestSuccess = {
//            (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
//            SVProgressHUD.dismiss()
//            self.photos = responseObject.objectForKey("photos").objectForKey("photo") as Array
//            self.collectionView.reloadData()
//            NSLog("requestSuccess \(responseObject)")
//        }
//        let requestFailure = {
//            (operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
//            SVProgressHUD.dismiss()
//            NSLog("requestFailure: \(error)")
//        }
//        SVProgressHUD.show()
//        manager.GET(url, parameters: parameters, success: requestSuccess, failure: requestFailure)
//    }
  


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOfImage.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = UIColor.black
        
        return cell
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            loadSomeDataAndIncreaseDataLengthFunction()
            self.collectionView?.reloadData()
        }
    }
    
    var i = 0
    
    func loadSomeDataAndIncreaseDataLengthFunction() {
        self.i += 1
        print(i)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem = view.frame.width / itemsPerRow - borderWidth
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  borderWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return borderWidth
    }
}
