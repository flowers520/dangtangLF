

import UIKit
import SnapKit

class LFSeeAllTopicCell: UITableViewCell {

    var bgImageView: UIImageView!
    var placeholderButton: UIButton!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    var longView: UIView!
    var leftView = UIView()
    var rightView = UIView()
    var seeTopicLabel = UILabel()
    
    var collection: LFCollection?{
        didSet{
            let url = collection?.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
                self.placeholderButton.hidden = true
            }
            titleLabel.text = collection?.title
            subtitleLabel.text = collection?.subtitle
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        bgImageView = UIImageView(frame: CGRectMake(8, 8, SCREENW-8-8, 144))
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        addSubview(bgImageView)
        
        placeholderButton = UIButton(frame: CGRectMake(144,67,31,26))
        placeholderButton.setImage(UIImage(named: "PlaceHolderImage_small_31x26_"), forState: .Normal)
        addSubview(placeholderButton)
        
        titleLabel = UILabel(frame: CGRectMake(0,43,SCREENW,24))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20.0)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Label"
        addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRectMake(0,93,SCREENW,21))
        subtitleLabel.text = "Label"
        subtitleLabel.textAlignment = .Center
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.font = UIFont.systemFontOfSize(17.0)
        subtitleLabel.adjustsFontSizeToFitWidth = true
        addSubview(subtitleLabel)
        
        longView = UIView(frame: CGRectMake(8,77,SCREENW-8-8,5))
        addSubview(longView)
        
        leftView.backgroundColor = UIColor.whiteColor()
        longView.addSubview(leftView)
        leftView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(longView).offset(20)
            make.top.equalTo(longView).offset(2)
            make.size.equalTo(CGSizeMake((SCREENW-61)/2, 1))
        }
        
        rightView.backgroundColor = UIColor.whiteColor()
        longView.addSubview(rightView)
        rightView.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(longView).offset(-20)
            make.top.equalTo(longView).offset(2)
            make.size.equalTo(CGSizeMake((SCREENW-59)/2, 1))
        }
        seeTopicLabel.backgroundColor = UIColor.clearColor()
        seeTopicLabel.text = "o"
        seeTopicLabel.textAlignment = .Center
        seeTopicLabel.font = UIFont.systemFontOfSize(10)
        seeTopicLabel.textColor = UIColor.whiteColor()
        longView.addSubview(seeTopicLabel)
        seeTopicLabel.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(6)
            make.center.equalTo(longView)
        }
    }
    
}
