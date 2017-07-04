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

class CollectionViewController: UICollectionViewController, CollieGalleryDelegate {
    @IBAction func barItem(_ sender: UIBarButtonItem) {
      itemsPerRow = 4
    self.collectionView?.reloadData()
    }
    
    fileprivate let borderWidth: CGFloat = 0.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    fileprivate var itemsPerRow: CGFloat = 2
    
    var arrayOfImage = [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]
    var arrayOfFlkrData : [FlickrFeedItem] = []
    
    
    var pictures = [CollieGalleryPicture]()
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout()
    }
    
    
    
    func layout() {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            itemsPerRow = 5
            self.collectionView?.reloadData()
        } else {
            print("Portrait")
            itemsPerRow = 3
            self.collectionView?.reloadData()
        }
    }
    
    var loadMoreStatus = false
    var pageNum = 1
    
    func loadShots(page: Int) {
        if !loadMoreStatus {
            loadMoreStatus = true
            pageNum += 1
            
            FlickrServices.instance.getShotsFeed(page: page, successCallback: {[weak self] feedItems in
                guard let `self` = self else { return }
                
                self.arrayOfFlkrData += feedItems
                self.collectionView?.reloadData()
                self.loadMoreStatus = false
                
                
                for i in 0 ..< feedItems.count {
                    let url = "https://farm\(feedItems[i].farm).staticflickr.com/\(feedItems[i].server)/\(feedItems[i].id)_\(feedItems[i].secret)_b.jpg"
                    let picture = CollieGalleryPicture(url: url)
                    self.pictures.append(picture)
                }
                
                
                
                
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
        
//        let urlstring = "https://farm\(arrayOfFlkrData[indexPath.row].farm).staticflickr.com/\(arrayOfFlkrData[indexPath.row].server)/\(arrayOfFlkrData[indexPath.row].id)_\(arrayOfFlkrData[indexPath.row].secret)_m.jpg"
//        
//        let picture = CollieGalleryPicture(url: urlstring)
//        pictures.append(picture)
        
       // print("array of datat is \(arrayOfFlkrData.count)")
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
    
  
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
       
        print("tap at \(indexPath.row)")
        let gallery = CollieGallery(pictures: pictures)
        
        
        gallery.presentInViewController(self)
        gallery.scrollToIndex(0, animated: false)
        
       // gallery.scrollToIndex(3, animated: false)
        
        print("gallery index \(gallery.currentPageIndex)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // your code here
            gallery.scrollToIndex(indexPath.row, animated: false)
            print(gallery.currentPageIndex)
        }
        
        
    
        
      
        
        return false
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let url = thumbnailFileURLS[indexPath.item]
//        if UIApplication.sharedApplication().canOpenURL(url) {
//            UIApplication.sharedApplication().openURL(url)
//        }
//        print("i = \( indexPath.row)")
//        
//    }
    
    
    
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
