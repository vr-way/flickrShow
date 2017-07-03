//
//  CollectionViewController.swift
//  FlickrSlideShow
//
//  Created by vrway on 01/07/2017.
//  Copyright © 2017 vrway. All rights reserved.
//

import UIKit
import CollieGallery

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    fileprivate let borderWidth: CGFloat = 0.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 3
    
    var arrayOfImage = [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]
    var arrayOfFlkrData : [FlickrFeedItem] = []
    
    
    var pictures = [CollieGalleryPicture]()
    
    let url = "https://www.flickr.com/photos/115319555@N06/35644941946/"
    let picture = CollieGalleryPicture(url: url)
    pictures.append(picture)
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        //loadShots(page: pageNum)
  
    }

    var loadMoreStatus = false
    var pageNum = 1
    
    func loadShots(page: Int) {
        if !loadMoreStatus {
            loadMoreStatus = true
            pageNum += 1
            
            FlickrServices.instance.getShotsFeed(page: page, successCallback: {[weak self] feedItems in
                guard let `self` = self else { return }
                print("loadding")
                self.arrayOfFlkrData += feedItems
                self.collectionView?.reloadData()
                self.loadMoreStatus = false
                
                }, errorCallback: { error in
                    print(error)
            })
        }
    }

    
    
    
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOfFlkrData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlckrCollectionViewCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.black
        
        if !arrayOfFlkrData.isEmpty { cell.setData(arrayOfFlkrData[indexPath.row])}
       
        print("array of datat is \(arrayOfFlkrData.count)")
        return cell
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - (2 * scrollView.frame.size.height) {
            loadSomeDataAndIncreaseDataLengthFunction()
            self.collectionView?.reloadData()
        }
    }
    
    var i = 0
    
    func loadSomeDataAndIncreaseDataLengthFunction() {
        self.i += 1
        loadShots(page: pageNum)
        //print("index is \(i)")
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
