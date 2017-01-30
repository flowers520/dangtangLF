import UIKit
import Kingfisher

class LFCategoryCollectionViewCell: UICollectionViewCell {

    var placeholderButton: UIButton!
    
    var collection: LFCollection? {
        didSet{
            let url = collection?.banner_image_url
            collectionImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
                self.placeholderButton.hidden = true
            }
        }
    
    }
    
    var collectionImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.placeholderButton = UIButton(frame: CGRectMake(59,25,31,26))
        self.placeholderButton.setImage(UIImage(named: "PlaceHolderImage_small_31x26_"), forState: .Normal)
        self.addSubview(self.placeholderButton)
        
        self.collectionImageView = UIImageView(frame: CGRectMake(0, 0, 150, 75))
        collectionImageView.layer.cornerRadius = kCornerRadius
        collectionImageView.layer.masksToBounds = true
        self.addSubview(self.collectionImageView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    

}
