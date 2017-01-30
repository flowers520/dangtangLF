import UIKit

protocol LFTopHeaderViewDelegate: NSObjectProtocol{
    func topViewDidClickedMoreButton(button: UIButton)
}

class LFTopHeaderView: UIView {
    
    weak var delegate: LFTopHeaderViewDelegate?
    
    var lookAllLabel: UILabel!
    var lookAllButton: UIButton!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lookAllLabel = UILabel(frame: CGRectMake(10,0,64,40))
        self.lookAllLabel.text = "专题合集"
        self.lookAllLabel.backgroundColor = UIColor.clearColor()
        self.lookAllLabel.textColor = UIColor.blackColor()
        self.lookAllLabel.textAlignment = NSTextAlignment.Left
        self.lookAllLabel.font = UIFont.systemFontOfSize(16.0)
        self.addSubview(self.lookAllLabel)
        
        self.lookAllButton = UIButton(frame: CGRectMake(SCREENW-(65+10), 0, 65, 40))
        self.lookAllButton.setTitle("查看全部>", forState: .Normal)
        self.lookAllButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.lookAllButton.titleLabel?.font = UIFont.systemFontOfSize(13.0)
//        self.lookAllButton.setImage(UIImage(named: "Category_PostCollectionSeeAll_5x8_"), forState: .Normal)
        self.lookAllButton.addTarget(self, action: Selector("viewAllButton:"), forControlEvents: .TouchUpInside)
        self.addSubview(self.lookAllButton)
        
    }
    
    func viewAllButton(sender: UIButton) {
        delegate?.topViewDidClickedMoreButton(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
