

import UIKit

class LFLookAllButton: UIButton {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //调整文字
        titleLabel?.frame.origin.x = 0
        titleLabel?.frame.origin.y = 0
        titleLabel?.frame.size.width = 55
        titleLabel?.frame.size.height = self.frame.height
        //调整图片
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)!
        imageView?.frame.origin.y = 12
        imageView?.frame.size.width = 10
        imageView?.frame.size.height = 16
    }

}
