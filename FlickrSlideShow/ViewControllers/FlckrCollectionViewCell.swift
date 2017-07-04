

import UIKit
import SDWebImage

class FlckrCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageShot: UIImageView!
    
    
    func setData( _ data: FlickrFeedItem) {

        let urlstring = "https://farm\(data.farm).staticflickr.com/\(data.server)/\(data.id)_\(data.secret)_q.jpg"
        let url = URL(string: urlstring)

        imageShot.sd_setImage(with: url, placeholderImage: UIImage(named: "flkrLoad"))
        
    }
    
    
}
