

import UIKit
import CollieGallery


private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
 
    
    fileprivate let borderWidth: CGFloat = 3.0
    fileprivate var itemsPerRow: CGFloat = 0.0
    fileprivate var itemsPerLandscape: CGFloat = 6.0
    fileprivate var itemsPerPortrait: CGFloat = 3.0

    var arrayOfFlkrData : [FlickrFeedItem] = []
    var fullSizeShots = [CollieGalleryPicture]()
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating...")
        refreshControl.addTarget(self, action: #selector(CollectionViewController.refreshInvoked(_:)), for: UIControlEvents.valueChanged)
        collectionView?.addSubview(refreshControl)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout()
    }
    
    func refreshInvoked(_ sender: AnyObject) {
        sender.beginRefreshing()
        pageNum = 1
        arrayOfFlkrData.removeAll()
        fullSizeShots.removeAll()
        
        loadShots(page: 1)
        sender.endRefreshing()
    }
    
    func layout() {
        if UIDevice.current.orientation.isLandscape {
            itemsPerRow = itemsPerLandscape
            self.collectionView?.reloadData()
        } else {
            itemsPerRow = itemsPerPortrait
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
                        self.fullSizeShots.append(picture)
                    }
                    
                
                }, errorCallback: { error in
                    print(error)
            })
        }
    }
    
}

// MARK: UICollectionViewDataSource

extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfFlkrData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlckrCollectionViewCell
        
        if !arrayOfFlkrData.isEmpty { cell.setData(arrayOfFlkrData[indexPath.row])}
        
        return cell
    }
    
}


// MARK: UICollectionViewDelegate

extension CollectionViewController {
    
    
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        //present slideShow
        let gallery = CollieGallery(pictures: fullSizeShots)
        gallery.presentInViewController(self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            gallery.scrollToIndex(indexPath.row, animated: false)
        }
        
        return false
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - (2 * scrollView.frame.size.height) {
            loadShots(page: pageNum)
            self.collectionView?.reloadData()
        }
    }
    
    
    
}





// MARK: UICollectionViewFlowLayout

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
